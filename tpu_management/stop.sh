ctpu pause -name ssy-mtf-ctpu
gcloud compute tpus stop  ssy-mtf-ctpu --zone=us-central1-b
while true
do
	ctpu list
	ctpu st
done

