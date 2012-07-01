RUN {
change archivelog all crosscheck;
change archivelog all validate;
delete noprompt expired archivelog all;
BACKUP AS COMPRESSED BACKUPSET FORMAT 'C:\backup\rman\ORCL_%d_%s_%p.bkp' DATABASE PLUS ARCHIVELOG DELETE INPUT;
BACKUP CURRENT CONTROLFILE SPFILE;
CROSSCHECK BACKUP;
DELETE NOPROMPT OBSOLETE;
DELETE NOPROMPT EXPIRED BACKUP;
}
Run
{
allocate channel c1 type disk;
backup current controlfile;
}