with t as (

    SELECT 'abc,1234,asdasd,ioaisdo' str from dual

)
select level as n, regexp_substr(str,'[^,]+',1,level) as val
from   t
connect by regexp_substr(str,'[^,]+',1,level) is not null;
