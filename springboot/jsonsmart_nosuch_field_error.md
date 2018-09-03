# ERRO

```
Caused by: java.lang.NoSuchFieldError: defaultReader
	at com.jayway.jsonpath.spi.json.JsonSmartJsonProvider.<init>(JsonSmartJsonProvider.java:39)
	at com.jayway.jsonpath.internal.DefaultsImpl.jsonProvider(DefaultsImpl.java:21)
```

# SOLUÇÃO

Adicionar a versão:

```xml
		<dependency>
			<groupId>com.microsoft.sqlserver</groupId>
			<artifactId>mssql-jdbc</artifactId>
			<version>7.0.0.jre8</version>
		</dependency>
```
