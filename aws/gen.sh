#!/bin/bash
#echo $#
if [ "$#" -ne 1 ]; then
    echo "Usage : source gen.sh <instance_ID>"
		return 1
fi
echo $1

aws ec2 describe-instances > /tmp/tt
awk -v instance_ID=$1 '{if($1=="INSTANCES") {instID=$8;ip=$15;split($12,arr,"\.");region=arr[2];} else if($1=="TAGS" && $2=="Name" && $3==instance_ID) {print "export CURRENT_INSTANCE_ID=" instID ; print "export CURRENT_REGION_ID=" region; print "export CURRENT_IP=" ip; exit 1}}' /tmp/tt > setting.sh
source setting.sh

aws ec2 describe-addresses --public-ips $CURRENT_IP |awk '{print "export CURRENT_IPID=" $2}' > setting1.sh
source setting1.sh

