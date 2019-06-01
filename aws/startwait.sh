aws ec2 start-instances --instance-ids $CURRENT_INSTANCE_ID
aws ec2 wait instance-running --instance-ids $CURRENT_INSTANCE_ID
source describe.sh |grep -i "^\<STATE\>"

