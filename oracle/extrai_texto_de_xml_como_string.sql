select extract(xmltype(COLUNA), '//inicio/text()').getStringVal() from table;
