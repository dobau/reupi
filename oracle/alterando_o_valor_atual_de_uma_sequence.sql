-- Alterando o valor atual de uma sequence
alter sequence <SEQUENCE> increment by 64711;
select <SEQUENCE>.NEXTVAL from dual;
alter sequence <SEQUENCE> increment by 1;