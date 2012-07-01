-- Mostra objetos locados
select 
distinct to_name object_locked
from 
v$object_dependency 
where 
to_address in
(
select /*+ ordered */
w.kgllkhdl address
from 
dba_kgllock w, 
dba_kgllock h, 
v$session w1, 
v$session h1
where
(((h.kgllkmod != 0) and (h.kgllkmod != 1)
and ((h.kgllkreq = 0) or (h.kgllkreq = 1)))
and
(((w.kgllkmod = 0) or (w.kgllkmod= 1))
and ((w.kgllkreq != 0) and (w.kgllkreq != 1))))
and w.kgllktype = h.kgllktype
and w.kgllkhdl = h.kgllkhdl
and w.kgllkuse = w1.saddr
and h.kgllkuse = h1.saddr
);