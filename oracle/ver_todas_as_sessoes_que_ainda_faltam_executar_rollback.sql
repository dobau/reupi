-- Ver todas as sessões que ainda falta executar rollback
SELECT
    vt.used_ublk ,
    vs.sid,
    vs.serial#,
    vs.username,
    vs.status,
    vs.schemaname,
    vs.osuser,
    vs.machine,
    vs.terminal,
    vs.program,
    vs.prev_hash_value,
    vs.sql_hash_value,
    vt.start_ubablk,
    used_urec
FROM v$session vs, v$transaction vt, v$sqlarea a
WHERE vs.taddr = vt.addr
AND bitand(vt.flag,POWER(2,7))> 0
AND a.hash_value(+) =
    DECODE(vs.sql_hash_value,
            0,vs.prev_hash_value,
            vs.sql_hash_value)