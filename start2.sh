#!/bin/bash
gnome-terminal -x bash -c "./thread.sh;exec bash" > /dev/null
rm ps1.txt ps.txt psremain.txt
touch ps1.txt ps.txt psremain.txt
ps -A | grep 'bash' > psremain1.txt
NUM=`cat psremain1.txt | wc -l`
NUM=$(($NUM+1))
for ((i=1;i<$NUM;i++))
do
	OOO=`sed -n "$i,$i p" psremain1.txt | cut -d " " -f 1 `
	if [ $OOO != "" ]
	then
		echo "$OOO" >>psremain.txt
	else
		OOO=`sed -n "$i,$i p" psremain1.txt | cut -d " " -f 2 `
		echo "$OOO" >>psremain.txt
	fi
done
NN=`cat psremain.txt | wc -l`
NNN=`sed -n "$NN,$NN p" psremain.txt`
NN=$(($NN+1))
while ((1))
do
	echo "arpspoof start"
	`./arp.sh $1 $2 $3`
	echo "---waiting---"
	`cp ps.txt ps1.txt`
	MM=`cat ps1.txt | wc -l`
	MM=$(($MM+1))
	for ((i=1;i<$MM;i++))
	do
		MMM=`sed -n "$i,$i p" ps1.txt`
		JDG=0	
		for ((j=1;j<$NN;j++))
		do
			NNN=`sed -n "$j,$j p" psremain.txt`
			if [ $MMM -eq $NNN ]
			then
				echo "$MMM == $NNN jump"
				JDG=1
				break
			else
				continue
			fi
		done
		if [ $JDG -eq 0 ]
		then
			echo "kill $MMM"
			`kill -9 $MMM`
		fi
	done
	ps -A | grep 'bash' > ps2.txt
	NUM=`cat ps2.txt | wc -l`
        NUM=$(($NUM+1))
	rm ps.txt
	touch ps.txt
	for ((i=1;i<$NUM;i++))
	do
		OOO=`sed -n "$i,$i p" ps2.txt | cut -d " " -f 1 `
		if [ $OOO != "" ]
		then
			echo "$OOO" >>ps.txt
		else
			OOO=`sed -n "$i,$i p" ps2.txt | cut -d " " -f 2 `
			echo "$OOO" >>ps.txt
		fi
	done
	for ((a=30;a>0;a--))
	do
		echo "$a"
		sleep 1s
	done
done
