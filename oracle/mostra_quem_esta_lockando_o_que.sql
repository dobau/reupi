-- Mostra quem está lockando o que
select 
  oracle_username
  os_user_name,
  locked_mode,
  object_name,
  object_type
from 
  v$locked_object a,dba_objects b
where 
  a.object_id = b.object_id