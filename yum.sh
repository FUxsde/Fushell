#!/bin/bash
#挂载 

dir=/media/cdrom
umount /dev/sr0 
[ -d $dir ] || mkdir $dir
[ -d /media/cdrom/Packages ] || mount /dev/sr0 $dir

#编辑repo文件
rm -rf /etc/yum.repos.d/*
echo "[cdrom]
name=cdrom
baseurl=file://$dir
enabled=1
gpgcheck=0" > /etc/yum.repos.d/123.repo

#重建缓存
yum clean all > /dev/null && yum makecache
