-- Pesquisa em todos os objetos da base um texto especifico

SELECT name, line, text
  FROM dba_source
 WHERE upper(text) like upper('%TPASVP02%') escape '\' 
