select *
  from tabela
 where coluna between coluna - to_dsinterval('+0 00:00:02') and coluna + to_dsinterval('+0 00:00:02').
