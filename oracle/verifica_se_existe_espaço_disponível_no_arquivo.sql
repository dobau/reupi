-- Verifica se existe espaço disponível no arquivo de dados (datafiles) e se eles são extensíveis 
select
a.file_id,
b.file_name,
b.autoextensible,
b.bytes/1024/1024 t1,
sum(a.bytes)/1024/1024 t2
from dba_extents a , dba_data_files b
where a.file_id=b.file_id
group by
a.file_id,b.file_name, autoextensible, b.bytes/1024/1024