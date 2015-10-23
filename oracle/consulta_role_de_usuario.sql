SELECT * FROM DBA_role_privs
where GRANTEE like 'USUARIO%'
order by GRANTEE;
