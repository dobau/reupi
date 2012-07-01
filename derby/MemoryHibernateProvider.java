package com.cgmp.provider;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.lang.reflect.Field;
import java.net.URL;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.SQLNonTransientConnectionException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Properties;

import org.hibernate.HibernateException;
import org.hibernate.cfg.Environment;
import org.hibernate.connection.ConnectionProvider;
import org.hibernate.connection.DatasourceConnectionProvider;
import org.hibernate.connection.DriverManagerConnectionProvider;
import org.hibernate.connection.UserSuppliedConnectionProvider;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class MemoryHibernateProvider implements ConnectionProvider {

    private static final Logger log = LoggerFactory.getLogger(MemoryHibernateProvider.class);

    private Properties allProperties;
    private int statusBkp = 0;
    private ConnectionProvider realConnectionProvider;

    private static final String BACKUP_FOLDER = "cgmp.bacbkup.folder";
    
    private static final int SHOULD_CREATE_BKP = 1;
    private static final int BKP_CREATED = 2;
    private static final int NO_BKP = 3;

    private static final String DEFAULT_BKP_NAME = "database";
    private static final String NO_IMPORT_SQL = "no_import_sql";
    
    public MemoryHibernateProvider() {
    }

    public MemoryHibernateProvider(ConnectionProvider connectionProvider) {
        this.realConnectionProvider = connectionProvider;
    }

    public void configure(Properties props) throws HibernateException {
        if ( props.getProperty(Environment.DATASOURCE)!=null ) {
            realConnectionProvider = new DatasourceConnectionProvider();
        } else if ( props.getProperty(Environment.URL)!=null ) {
            realConnectionProvider = new DriverManagerConnectionProvider();
        } else {
            realConnectionProvider = new UserSuppliedConnectionProvider();
        }
        
        this.allProperties = props;
        this.statusBkp = verifyShouldCreateBkp();
        
        if (statusBkp == BKP_CREATED) {
            props.setProperty(Environment.HBM2DDL_AUTO, "");
            props.setProperty(Environment.URL, getUrlCreateFrom());
        }
        
        if (BKP_CREATED == statusBkp || SHOULD_CREATE_BKP == statusBkp) {
            String bkpPath = props.getProperty(BACKUP_FOLDER);
            if (bkpPath == null || bkpPath.length() == 0) {
                props.setProperty(BACKUP_FOLDER, DEFAULT_BKP_NAME);
            }
        }

        realConnectionProvider.configure(props);
    }

    public Connection getConnection() throws SQLException {
        return realConnectionProvider.getConnection();
    }

    public void closeConnection(Connection conn) throws SQLException {
        if (statusBkp == SHOULD_CREATE_BKP && databaseIsPopulate(conn)) {
            createBkp(conn);
        }
        
        realConnectionProvider.closeConnection(conn);
        
        if (BKP_CREATED == statusBkp && conn.isClosed()) {
            log.info("Stopping in-memory database.");
            try {
                DriverManager.getConnection(getUrlWithoutProperty() + ";shutdown=true").close();
            } catch (SQLNonTransientConnectionException ex) {
                if (ex.getErrorCode() != 45000) {
                    throw ex;
                }
            }
        }
    }

    protected void finalize() {
        close();
    }

    public void close() {
        realConnectionProvider.close();
    }

    public boolean supportsAggressiveRelease() {
        return realConnectionProvider.supportsAggressiveRelease();
    }
    
    private boolean databaseIsPopulate(Connection conn) throws SQLException {
        boolean populate = false;

        Statement stmt = conn.createStatement();
        ResultSet tables = stmt.executeQuery("SELECT * FROM sys.sysschemas s, sys.systables t WHERE s.schemaid = t.schemaid and t.tabletype = 'T'");
        while (tables.next() && !populate) {
            populate = true;
        }
        tables.close();
        
        return populate;
    }

    private int verifyShouldCreateBkp() {
        String url = allProperties.getProperty(Environment.URL);
        if (!url.startsWith("jdbc:derby:memory") || !url.contains(";create=true")) {
            return NO_BKP;
        }

        File file = new File(allProperties.getProperty(BACKUP_FOLDER));
        if (!file.exists() || isModified()) {
            return SHOULD_CREATE_BKP;
        } else {
            return BKP_CREATED;
        }
    }

    private boolean isModified() {
        File chkFile = new File(getFolderCreateFrom() + "\\chk");
        
        byte[] currentCheckpoint = getCheckPointText();
        byte[] readedCheckpoint = NO_IMPORT_SQL.getBytes();
        
        if (chkFile.isFile()) {
            try {
                FileInputStream reader = new FileInputStream(chkFile);

                int size = reader.available();
                if (size != 0) {
                    byte[] buffer = new byte[size];
                    reader.read(buffer);
                    
                    readedCheckpoint = buffer;
                }
                
                reader.close();
            } catch(IOException ex) {
                log.info("Can't find checkpoint file");
            }
        }

        return !Arrays.equals(currentCheckpoint, readedCheckpoint);
    }

    private void createBkp(Connection conn) throws SQLException {
        executeBkp(conn);
        createCheckpointFile();
        
        String urlCreateFrom = getUrlCreateFrom();
        
        allProperties.setProperty(Environment.URL, urlCreateFrom);
        allProperties.setProperty(Environment.HBM2DDL_AUTO, "");
        
        if (realConnectionProvider instanceof DriverManagerConnectionProvider) {
            try {
                Field urlField = realConnectionProvider.getClass().getDeclaredField("url");
                urlField.setAccessible(true);
                urlField.set(realConnectionProvider, urlCreateFrom);
                urlField.setAccessible(false);
            } catch(Exception ex) {
                log.info("Can't change url in realConnectionProvider to {}", realConnectionProvider);
            }
        }

        statusBkp = BKP_CREATED;
    }

    private void createCheckpointFile() {
        try {
            BufferedOutputStream writer = new BufferedOutputStream(new FileOutputStream(getFolderCreateFrom() + "\\chk"));
            writer.write(getCheckPointText());
            writer.close();
        } catch(IOException e) {
            log.info("Can't create check file");
        }
    }

    private byte[] getCheckPointText() {
        String randomTxt = NO_IMPORT_SQL;
        
        URL importSqlFile = Thread.currentThread().getContextClassLoader().getResource("import.sql");
        if (importSqlFile != null) {
            File file;
            try {
                file = new File(importSqlFile.toURI());
            } catch(Exception ex) {
                file = new File(importSqlFile.getPath());
            }
            randomTxt = "" + file.lastModified() + file.length();
        }

        byte[] chk;
        try {
            chk = MessageDigest.getInstance("MD5").digest(randomTxt.getBytes());
        } catch (NoSuchAlgorithmException e) {
            chk = randomTxt.getBytes();
        }
        
        return chk;
    }

    private String getFolderCreateFrom() {
        return allProperties.getProperty(BACKUP_FOLDER) + "\\" + getDatabaseName();
    }
    
    private String getUrlCreateFrom() {
        return getUrlWithoutProperty() + ";createFrom=" + getFolderCreateFrom();
    }

    private String getDatabaseName() {
        String url = allProperties.getProperty(Environment.URL);
        return url.substring(url.lastIndexOf(':') + 1, url.indexOf(';'));
    }

    public void executeBkp(Connection conn)throws SQLException {
        String backupdirectory = allProperties.getProperty(BACKUP_FOLDER);
        CallableStatement cs = conn.prepareCall("CALL SYSCS_UTIL.SYSCS_BACKUP_DATABASE(?)"); 
        cs.setString(1, backupdirectory);
        cs.execute(); 
        cs.close();
        log.info("backed up database to "+backupdirectory);
    }
    
    private String getUrlWithoutProperty() {
        String url = allProperties.getProperty(Environment.URL);
        return url.substring(0, url.indexOf(';'));
    }

    public ConnectionProvider getRealConnectionProvider() {
        return realConnectionProvider;
    }

    public void setRealConnectionProvider(ConnectionProvider realConnectionProvider) {
        this.realConnectionProvider = realConnectionProvider;
    }
    
}