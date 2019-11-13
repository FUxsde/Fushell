#!/bin/bash
#made in china 
#date:2019-09-03
read -p "定义网址：" w
read -p "定义子网掩码：" e
read -p "定义网关：" r
read -p "定义dns：" d
file=/etc/sysconfig/network-scripts/ifcfg-eno16777728
ob=$(cat $file | sed -nr 's/(ONBOOT)=(.*)/\2/gp')
[ $ob = yes ] || sed -i "/^ONBOOT/ s/no/yes/g" $file
q=$(cat $file | sed -nr 's/(BOOTPROTO)=(.*)/\2/gp')
sed -nr "s/(BOOTPROTO)=(.*)/\2/g" $file
if [ $q = "static" ] || [ $q = "none" ]
then
	sed -i "/^IPADDR/ s/=.*/=$w/g" $file
	sed -i "/^NETMASK/ s/=.*/=$e/g" $file
	sed -i "/^GATEWAY/ s/=.*/=$r/g" $file
	sed -i "/^DNS1/ s/=.*/=$d/g" $file
	systemctl restart network
else
	sed -i "s/dhcp/static/g" $file 
	sed -i "15a\nIPADDR=$w\nNETMASK=$e\nGATEWAY=$r\nDNS1=$d" $file
	systemctl restart network
fi
