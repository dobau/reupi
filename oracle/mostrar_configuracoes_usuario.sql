-- Mostrar configurações do profile por usuário
select * from dba_profiles a
inner join dba_users b on (a.profile=b.profile)
where username='APL_SVENDEDOR_CS';
