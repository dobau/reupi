SELECT NVL(s.username,
  (SELECT 'SYS('||b.name||')' FROM v$bgprocess b WHERE b.paddr = s.paddr
  )) username ,
  UPPER(s.osuser) osuser ,
  s.inst_id ,
  ''''
  ||s.sid
  ||','
  ||s.serial#
  ||'''' sidser ,
  p.spid ,
  s.status ,
  s.lockwait ,
  s.logon_time ,
  Floor(s.last_call_et/3600)
  ||':'
  || floor(mod(s.last_call_et,3600)/60)
  ||':'
  || mod(mod(s.last_call_et,3600),60) idle_time ,
  s.program ,
  S.machine ,
  Floor(s.last_call_et          /3600) np ,
  floor(mod(s.last_call_et,3600)/60) np ,
  mod(mod(s.last_call_et,3600),60) np
FROM gv$session s ,
  gv$process p
WHERE S.USERNAME LIKE '%'
  ||upper('APL_SVENDEDOR_CS')
  ||'%'
AND s.inst_id = p.inst_id
AND S.PADDR   = P.ADDR
ORDER BY 11, 9 desc;
