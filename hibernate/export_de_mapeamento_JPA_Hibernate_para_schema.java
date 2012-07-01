-- Export de mapeamento JPA/Hibernate para schema sql
AnnotationConfiguration configuration = new AnnotationConfiguration();

configuration
    .addAnnotatedClass(<classe>.class)
    .setProperty(Environment.USER, <usuario>)
    .setProperty(Environment.PASS, <senha>)
    .setProperty(Environment.URL, <url>)
    .setProperty(Environment.DIALECT, <dialeto>)
    .setProperty(Environment.DRIVER, <driver>);

SchemaExport schema = new SchemaExport(configuration);
schema.setOutputFile(<nome do arquivo>);
schema.setDelimiter(";");

schema.create(<criar arquivo de script>, <criar no banco>);