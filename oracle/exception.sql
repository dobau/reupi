BEGIN
...
EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
END;
