-- Recuperar todos os privilégios sobre um objeto
SELECT table_name, grantee,
MAX(DECODE(privilege, 'SELECT', 'SELECT')) AS select_priv,
MAX(DECODE(privilege, 'DELETE', 'DELETE')) AS delete_priv,
MAX(DECODE(privilege, 'UPDATE', 'UPDATE')) AS update_priv,
MAX(DECODE(privilege, 'INSERT', 'INSERT')) AS insert_priv
FROM dba_tab_privs
WHERE table_name = '<TABLE_NAME>' and grantee IN (
  SELECT role
  FROM dba_roles)
GROUP BY table_name, grantee;