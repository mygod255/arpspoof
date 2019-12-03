#!/bin/bash
while ((1))
do
	ps -A | grep 'fping' > fping.txt
	OOO=`sed -n "1,1 p" fping.txt | cut -d " " -f 1 `
	if [ $OOO != "" ]
	then
		kill -9 $OOO
	else
		OOO=`sed -n "1,1 p" fping.txt | cut -d " " -f 2 `
		kill -9 $OOO
	fi
	sleep 20s
done &
