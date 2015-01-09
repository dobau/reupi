select b.sql_text
  from gv$session a, gv$sqlarea b
   where a.sql_address=b.address
  and a.username like '<USUARIO>%' and a.status = 'ACTIVE' and a.machine = '<MAQUINA>';
