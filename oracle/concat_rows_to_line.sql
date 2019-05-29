SELECT pid, LISTAGG(Desc, ' ') WITHIN GROUP (ORDER BY seq) AS description
FROM B GROUP BY pid;
