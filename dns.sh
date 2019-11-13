#!/bin/bash
#DNS服务器构建

#关闭防火墙和安全机制
iptables -F
setenforce 0
systemctl stop firewalld

#yum安装bind软件
rpm -qa | grep bind-9.9 || yum -y install bind

#vim编辑/etc/reslov.conf文件添加dns服务器
cat << END > /etc/reslov.conf
search crushlinux.com
nameserver 202.106.0.20
nameserver 192.168.180.180
nameserver 192.168.180.181
END

#vim编辑hosts文件添加域名解析
cat << END > /etc/hosts
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
192.168.180.180 gang.com
192.168.180.181 zhen.com
END

#vim编辑主配置文件/etc/named.conf
cat << END > /etc/named.conf
options {
        listen-on port 53 { 192.168.180.180; };
        directory       "/var/named";
        dump-file       "/var/named/data/cache_dump.db";
        statistics-file "/var/named/data/named_stats.txt";
        memstatistics-file "/var/named/data/named_mem_stats.txt";
        allow-query     { any; };
        recursion yes;
};
zone "gang.com" IN {
        type master;
        file gang.zheng";
        allow-transfer { 192.168.180.181; };
};
zone "180.168.192.in-addr.arpa" IN {
        type master;
        file "gang.fan";
        allow-transfer { 192.168.180.181; };
};
END

#vim编辑“zone”区域文件
cat << END > /var/named/gang.zheng
$TTL	86400
@	IN	SOA	gang.com. admin.gang.com. (
	20190825
	3H
	15M
	1W
	1D )

	IN	NS	ns1.gang.com.
	IN	NS	ns2.gang.com.
	IN	MX 10	mail.gang.com.
ns1	IN	A	192.168.180.180
ns2	IN	A	192.168.180.181
www	IN	A	192.168.180.182
study	IN	A	192.168.180.183
ftp	IN	CNAME	www
END

cat << END > /var/named.fan
$TTL    86400
@       IN      SOA     gang.com. admin.gang.com. (
        20190825
        3H
        15M
        1W
        1D )

        IN      NS      ns1.gang.com.
        IN      NS      ns2.gang.com.
        IN      MX 10   mail.gang.com.
180     IN      PTR	ns1.gang.com.
181     IN      PTR	ns2.gang.com.
182     IN      PTR	www.gang.com.
183     IN      PTR	study.gang.com.
END

#给与zone区域文件归属
chown :named /var/named/gang.*
echo "权限成功"

#启动服务
systemctl start named
if [ $? -eq 0 ]
then
echo "我就是卢来佛祖"
else
echo "快去请卢来佛祖"
fi
systemctl enable named
if [ $? -eq 0 ]
then
echo "还有谁"
else
echo "快请"
fi










