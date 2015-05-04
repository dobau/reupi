
-- hours
select 24 * (to_date('2009-07-07 22:00', 'YYYY-MM-DD hh24:mi') 
             - to_date('2009-07-07 19:30', 'YYYY-MM-DD hh24:mi')) diff_hours 
       from dual;
       
-- seconds
select 24*60*60 * (to_date('2009-07-07 22:00', 'YYYY-MM-DD hh24:mi') 
             - to_date('2009-07-07 19:30', 'YYYY-MM-DD hh24:mi')) diff_hours 
       from dual;
       
-- formated
select (floor(((DATE2-DATE1)*24*60*60)/3600)|| ' : ' ||floor((((DATE2-DATE1)*24*60*60) -floor(((DATE2-DATE1)*24*60*60)/3600)*3600)/60)|| '  ' ) as time_difference from TABLE1
