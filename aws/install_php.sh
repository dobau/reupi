#!/bin/bash
yum -y install httpd php
chkconfing httpd on
service httpd start

cd /var/www/html
wget https://bitbucket.org/awsdevguru/awsdevassoc/raw/cd3108e6d85d08f561136505f372f2728048a562/07._EC2/UserData/index.php
