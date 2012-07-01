-- Recupera select em formato XML
select dbms_xmlgen.getxml('select employee_id, first_name,2 last_name, phone_number from employees where rownum < 6') from dual
