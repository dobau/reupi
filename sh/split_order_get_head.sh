cat arquivo | grep ControlaParceiroPS | cut -d';' -f12 | sort -nrk 1 | head -1
