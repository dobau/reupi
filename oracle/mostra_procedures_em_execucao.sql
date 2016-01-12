select 'CALLED PLSQL', vs.username, d_o.object_name,  b.sql_fulltext, trim(to_char(floor(vs.LAST_CALL_ET/3600), '09')) || ':'
       || ltrim(to_char(floor(mod(vs.LAST_CALL_ET, 3600)/60), '09')) || ':'
       || ltrim(to_char(mod(vs.LAST_CALL_ET, 60), '09'))    RUNT -- whatever info you need
  from dba_objects d_o
       inner join gv$session vs on d_o.object_id = vs.plsql_entry_object_id
       inner join gv$sqlarea b on vs.sql_address=b.address
