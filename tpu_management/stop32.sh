ctpu pause -name ssy-mtf-ctpu -zone  us-central1-a
gcloud compute tpus stop  ssy-mtf-ctpu --zone=us-central1-a
while true
do
	ctpu list
	ctpu st
done

