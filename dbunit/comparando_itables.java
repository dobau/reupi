-- Comparando ITables do dbunit
ITable registroAuditoria = getConnection().createQueryTable("AUDITORIA_CANCELADA", "SELECT * FROM TBAUDVP01 WHERE AUVP_NM_COD_REGISTRO = 999999996 AND AUVP_NM_ACAO = 'E' AND AUVP_NM_TIPO_OPER = 'V'");
ITable expectedTable = getExpectedDataSet().getTable("AUDITORIA_VIAGEM_CANCELADA");

ITable filteredRegistroAuditoria = DefaultColumnFilter.excludedColumnsTable(registroAuditoria, new String[]{"AUVP_DT_OPER"});
ITable filteredExpectedTable = DefaultColumnFilter.excludedColumnsTable(expectedTable, new String[]{"AUVP_DT_OPER"});

Assertion.assertEquals(filteredExpectedTable, filteredRegistroAuditoria);