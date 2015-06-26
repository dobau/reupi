SELECT s.inst_id ,
  s.username ,
  MIN(s.logon_time) first_logon ,
  MAX(S.LOGON_TIME) LAST_LOGON ,
  COUNT(1) nr_conexoes ,
  S.STATUS
  ,S.MACHINE
FROM gv$session s ,
  gv$process p
WHERE P.INST_ID(+) = S.INST_ID
AND P.ADDR(+)      = S.PADDR
AND S.USERNAME    IS NOT NULL
AND S.USERNAME IN ('APL_SVENDEDOR_CS')
GROUP BY S.INST_ID, S.USERNAME, S.STATUS, S.MACHINE
ORDER BY S.MACHINE;
