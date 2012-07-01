-- Oracle
MERGE INTO test1 a
  USING all_objects b
    ON (a.object_id = b.object_id)
  WHEN MATCHED THEN
    UPDATE SET a.status = b.status
    WHERE  b.status != 'VALID';