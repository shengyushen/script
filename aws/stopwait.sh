aws ec2 stop-instances --instance-ids $CURRENT_INSTANCE_ID
aws ec2 wait instance-stopped --instance-ids $CURRENT_INSTANCE_ID
source describe.sh |grep -i "^\<STATE\>"
