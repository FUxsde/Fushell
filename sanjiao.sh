#!/bin/bash
#made in china 
#date:2019-08-31

for i in {1..15}
do
	for ((o=9;o>=$i;o--))
	do
	echo -n " "
	done
	
	for ((j=1;j<=$i;j++))
	do
	echo -n "*"
	done
	for ((j=1;j<=$i;j++))
	do
	echo -n "*"
	done
	echo
done	
