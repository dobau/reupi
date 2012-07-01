SELECT a.inst_id, a.session_id, b.serial#, b.status, a.oracle_username,
       a.os_user_name, a.process, c.name 
FROM   sys.obj$ c, gv$session b, gv$locked_object a 
WHERE  a.session_id=b.sid 
AND    c.obj#=a.object_id 