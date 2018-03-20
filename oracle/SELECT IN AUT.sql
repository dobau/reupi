        SELECT DECODE ( MOD(ROWNUM - 1, 1000), 0, DECODE(ROWNUM - 1, 0, '', ' ) UNION ') || ' SELECT col FROM tabela WHERE col IN ( ', ', ') || CD_CONTRATO
          FROM table2;
