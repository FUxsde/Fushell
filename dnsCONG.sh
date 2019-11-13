#!/bin/bash
#dhs从服务器配置

#安装dns服务
rpm -qa | grep bind-9.9 || yum -y install bind 

#vim编辑hosts文件添加域名解析
cat << END > /etc/hosts
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
192.168.180.180 gang.com
192.168.180.181 zhen.com
END

#编辑主配置文件/etc/named.conf
cat << END > /etc/named.conf
options {
        directory       "/var/named";
};
zone "gang.com" IN {
        type slave;
        file slavesgang.zheng";
        master { 192.168.180.180; };
};
zone "180.168.192.in-addr.arpa" IN {
        type slave;
        file "slaves/gang.fan";
        master { 192.168.180.180; };
};
END

#启动dns服务
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

