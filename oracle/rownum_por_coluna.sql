-- Cria coluna de ROWNUM com base em outras colunas

ROW_NUMBER() OVER (PARTITION BY a.lcvp_viagem, a.lcvp_seqprota ORDER BY a.lcvp_numero asc) NUM
