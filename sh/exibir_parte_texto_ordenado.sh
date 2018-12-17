 cat arquivo | grep <filtro> |awk -F ";" '{print $12 "   " $5}'|sort -g
