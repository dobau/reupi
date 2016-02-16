extract( day from (dt_fim-dt_inicio) )*24*60*60+
           extract( hour from (dt_fim-dt_inicio) )*60*60+
           extract( minute from (dt_fim-dt_inicio) )*60+
           extract( second from (dt_fim-dt_inicio))
