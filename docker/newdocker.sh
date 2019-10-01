# starting a new docker container
#nvidia-docker run -v /home/nfs1/ssy:/home/ssy --name ssyDetectronCuda80Cudnn6021 -it b9e15a5d1e1a 
nvidia-docker run -v /home/nfs1/ssy:/home/ssy -w /home/ssy --name ssyOmnetpp3 -it b9e15a5d1e1a 
