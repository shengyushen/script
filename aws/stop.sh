instanceID=$(aws ec2 describe-instances |awk -v IID=$1 '{if($1=="INSTANCES") {instanceID=$8}; if($1=="TAGS" && $2=="Name" && $3==IID) {print instanceID}}')
echo $instanceID
aws ec2 stop-instances --instance-ids $instanceID


