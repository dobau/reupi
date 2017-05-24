SELECT 
  sql_id,
  t.sql_text sql_text,  
  b.name bind_name,
  b.value_string bind_value 
FROM
  gv$sql t 
JOIN
  gv$sql_bind_capture b  using (sql_id)
WHERE
  b.value_string is not null  
AND
  sql_id='&sqlid'
