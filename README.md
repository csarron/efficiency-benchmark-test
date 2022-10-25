# beaker test


## prepare data

```bash
mkdir data && cd data

wget https://www.robots.ox.ac.uk/\~vgg/data/pets/data/images.tar.gz

tar xzf images.tar.gz

# now just run 
torchrun --nproc_per_node 2 src/complete_cv_example.py --data_dir data/images 2>&1 | tee data/run-cv.log

```


## gantry

```bash

# run using conda
gantry run \
-n test-cv \
--workspace ai2/br \
--cluster ai2/qicao-v100 \
--gpus 2 --conda env.yaml \
--dataset 'qicao/test-images:/data'  -- \
torchrun --nproc_per_node 2 \
complete_cv_example.py \
--data_dir /data 

# run using beaker image
gantry run \
--workspace ai2/br \
--cluster ai2/qicao-v100 \
--gpus 2 \
--beaker-image 'qicao/test-cv-docker' \
--venv 'eff' \
--dataset 'qicao/test-images:/data' -- \
torchrun --nproc_per_node 2 src/complete_cv_example.py --data_dir /data 

# build docker and create beaker image

docker build -t test-cv-docker .

beaker image create --name test-cv-docker test-cv-docker

# --dry-run \
# --save-spec beaker-spec.yaml \

# beaker create dataset

beaker dataset create --name test-images ./some-path



```