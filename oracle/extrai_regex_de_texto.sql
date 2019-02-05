-- OPTION 1
WITH PLACAS AS (
    select 'Asdahsudhasdh DTY-1212 aaa' texto from dual UNION ALL
    select 'Asd FVM-0713 dhasdh  aaa' texto from dual UNION ALL
    select 'AsdahsuDTY-1212dhasdh  aaa' texto from dual
)

select regexp_substr(texto, '\s\w\w\w-\d\d\d\d\s') from placas;


-- OPTION 2
select regexp_replace(a.TB0475_DS_DADOS, '(.*)(\d{4}\-\d{2}\-\d{2})(.*)', '\2') DATA_INICIAL from TABLE;
