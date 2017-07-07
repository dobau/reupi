select *
  from TABLE
 where existsNode(COLUMN, '//NO[text() = "VALOR"]', 'xmlns:X="urlNamespace"') > 0;
