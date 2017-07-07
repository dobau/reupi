select *
  from TABLE
 where existsNode(COLUMN, '//NO[text() = "VALOR"]') > 0;
