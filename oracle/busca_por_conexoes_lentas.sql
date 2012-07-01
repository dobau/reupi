-- Busca por conexões lentas
select
   b.machine         host,
   b.username        username,
   b.server,
   b.osuser          os_user,
   b.program         program,
   a.tablespace_name ts_name,
   row_wait_file#    file_nbr,
   row_wait_block#   block_nbr,
   c.owner,
   c.segment_name,
   c.segment_type
from
   dba_data_files a,
   v$session      b,
   dba_extents    c 
where b.row_wait_file# = a.file_id
and c.file_id = row_wait_file#
and row_wait_block#  between c.block_id and c.block_id + c.blocks - 1
and row_wait_file# <> 0
and type='USER';