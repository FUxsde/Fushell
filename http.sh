#!/bin/bash
#安装源代码方式的apache服务

rpm -qa | grep gcc-c++ || yum -y install gcc gcc-c++

tar xf httpd-2.2.17.tar.gz -C /usr/src
cd /usr/src/httpd-2.2.17
./configure --prefix=/usr/local/apache
make
make install
cd /usr/local/apache/conf
cp httpd.conf httpd.conf.bak
sed '/^ServerName/ s/^/#' httpd.conf

yum -y install lynx
/usr/local/apache/bin/apachectl start
