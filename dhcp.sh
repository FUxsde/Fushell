#!/bin/bash
#创建DHCP服务器

rpm -qa | grep "dhcp-4" || yum -y install dhcp
read -p "dhcp域名:" y
read -p "dhcpDNS服务器:" u
read -p "dhcp网段:" i
read -p "dhcp地址池:" o
read -p "dhcp网关:" p

cat << END > /etc/dhcp/dhcpd.conf
option domain-name "$y";
option domain-name-servers $u;

default-lease-time 600;
max-lease-time 7200;

subnet $i netmask 255.255.255.0 {
  range $o;
  option routers $p;
}
END
systemctl start dhcpd
if [ $? -eq 0 ]
then
echo "我就是卢来佛祖"
else
echo "快去请卢来佛祖"
fi
