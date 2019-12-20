-- create schema
create schema <schema>;

-- create table
CREATE TABLE <schema>.<table> (id string)
STORED AS PARQUET
LOCATION 's3://folder/<user>/<subfolder>/<table>/';

-- insert table
INSERT OVERWRITE TABLE <schema>.<table>
select tid
from (
  select split("1,2,3", ',') id
) t
lateral view explode(t.id) tids as tid;
