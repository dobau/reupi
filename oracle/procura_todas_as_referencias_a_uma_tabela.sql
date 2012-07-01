-- Procura todas as referências a uma tabela
select *
from dba_dependencies
where referenced_name = '<TABELA>' and owner = '<owner>'
order by referenced_owner, TYPE, NAME;