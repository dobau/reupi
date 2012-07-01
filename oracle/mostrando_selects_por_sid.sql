select  s.inst_id, substr(u.username,1,12) user_name,   s.sql_text 
from   gv$sql s, gv$session u 
where  s.hash_value = u.sql_hash_value 
and    s.inst_id = u.inst_id 
and    lower(sql_text) not like '%from v$sql s, v$session u%'
and    sid in (sid1, sid2, sid3);