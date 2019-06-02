aws ec2 allocate-address|awk '{print "export CURRENT_EIP=$3";print "export CURRENT_EIPID=$1"}' >setting.sh 
source setting.sh

