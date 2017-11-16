DECLARE
    X NUMBER;
BEGIN

    FOR N IN 1..10
    LOOP   
        select SEQUENCE.NEXTVAL INTO X from dual;
    END LOOP;

END;
