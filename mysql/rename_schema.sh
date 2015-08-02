## 1
mysqldump -u username -p -v olddatabase > olddbdump.sql
mysqladmin -u username -p create newdatabase
mysql -u username -p newdatabase < olddbdump.sql

## 2
mysqladmin -u username -p create newdatabase
mysqldump -u username -v olddatabase -p | mysql -u username -p -D newdatabase
