#!/bin/bash
#made in china 
#date:2019-08-30

echo "//==============================\\
|          用户管理系统          |
----------------------------------
|          1、创建用户           |
|          2、删除用户           |
|          3、锁定用户           |
|          4、解锁用户           |
|          5、查看用户           |
|          6、退出脚本           |
----------------------------------"
while true
do
read -p "输入你的操作选择：" num
#-------------------------------------创建用户--------------------------
if [ $num = 1 ]
then 
	read -p "请输入你的用户名：" use
	cat /etc/passwd | grep $use &> /dev/null
	if [ $? -eq 0 ]
		then 
			echo "账号名已存在"
		else
			useradd $use
			echo "123456" | passwd --stdin $use &> /dev/null
			chage -d 0 $use
			echo "初始密码：123456 登陆后自行修改"
	fi
fi
#-------------------------------------删除用户--------------------------
if [ $num = 2 ]
then 
	read -p "请输入你要删除的用户名：" use
	cat /etc/passwd | grep $use &> /dev/null
		if [ $? -eq 0 ]
			then
				userdel -r $use
				echo "用户已删除"
			else 
				echo "查无此人"
		fi
fi
#-------------------------------------锁定用户--------------------------
if [ $num = 3 ]
then 
	read -p "请输入你要锁定的用户名：" use
	passwd -S $use | grep PS &> /dev/null
	if [ $? -eq 0 ]
	then 
		passwd -l $use &> /dev/null
	echo "$use 账户已锁定"
	else
		echo "你好好看看锁定了没有"
	fi
fi
#-------------------------------------解锁用户--------------------------
if [ $num = 4 ]
then
	read -p "请输入你要解锁的用户名：" use	
	passwd -S $use | grep PS > /dev/null
	if [ $? -eq 0 ]
	then
		echo "你好好看看锁定了没有"
	else
		passwd -u $use &> /dev/null
		echo "$use 账户已解锁"
	fi
fi
#-------------------------------------查看用户----------------------------
if [ $num = 5 ]
then 
	read -p "请输入你要查看的用户名：" use
	passwd -S $use 
fi
#-------------------------------------推出脚本----------------------------
if [ $num = 6 ]
then 
	echo "再见"
	sleep 3
	exit
fi
done





















	
















