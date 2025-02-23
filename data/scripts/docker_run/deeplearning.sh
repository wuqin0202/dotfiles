docker run \
 -it \
 --name mic \
 --gpus all \
 --log-opt max-size=1m \
 --network host \
 -e PUID=$UID \
 -e PGID=$GID \
 -v $HOME/Workspace/DeepLearning/papers/mic:/workspace/mic \
 -v /mnt/DeepLearningDatasets/:/data \
 --shm-size=4g \
 torch:python3.8.5-torch1.7.1-cuda11.0-cudnn8 \
 /bin/zsh
