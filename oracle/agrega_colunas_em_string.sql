select ppvp_viagem, listagg (ppvp_codcon || '-' || PPVP_PRACA, ',')  WITHIN GROUP  (ORDER BY ppvp_codcon || '-' || PPVP_PRACA) pracas
  from tppvgvp1
 where ppvp_viagem = 24667847
 group by ppvp_viagem;
