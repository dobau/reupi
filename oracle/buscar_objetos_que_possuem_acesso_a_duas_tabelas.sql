-- Procura todos os objetos onde existe referência a duas tabelas distintas

SELECT distinct a.name
  FROM dba_source a, dba_source b
 WHERE
 a.owner = b.owner and
 a.NAME = b.NAME and
 upper(a.text) like upper('%TPASVP02%') and
 upper(b.text) like upper('%TPPVGVP1%') and
 a.line > b.line
