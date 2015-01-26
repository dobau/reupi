SELECT distinct a.name
FROM dba_source a
WHERE upper(a.text) like upper('%TLCTAPD1%')
