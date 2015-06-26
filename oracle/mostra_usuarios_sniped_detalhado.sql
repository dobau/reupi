SELECT s.sid, s.inst_id ,
  s.username ,
  MIN(s.logon_time) first_logon ,
  MAX(S.LOGON_TIME) LAST_LOGON ,
  COUNT(1) nr_conexoes ,
  S.STATUS,
  S.STATE,
  S.PROCESS,
  (s.wait_time_micro * 0.000001)
FROM gv$session s ,
  gv$process p
WHERE P.INST_ID(+) = S.INST_ID
AND P.ADDR(+)      = S.PADDR
AND S.USERNAME    IS NOT NULL
AND S.USERNAME LIKE '%APL_SITERS_CS%'
AND s.status like '%SNIPED%'
GROUP BY S.SID, S.INST_ID, S.USERNAME, S.STATUS, S.STATE, S.PROCESS, (S.WAIT_TIME_MICRO * 0.000001)
ORDER BY 10 DESC;
