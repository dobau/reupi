WITH PLACAS AS (
    select 'Asdahsudhasdh DTY-1212 aaa' texto from dual UNION ALL
    select 'Asd FVM-0713 dhasdh  aaa' texto from dual UNION ALL
    select 'AsdahsuDTY-1212dhasdh  aaa' texto from dual
)

select regexp_substr(texto, '\s\w\w\w-\d\d\d\d\s') from placas;
