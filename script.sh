#!/usr/bin/bash
# nextflow
mkdir /opt/checkouts/ -p
git clone https://github.com/nextflow-io/nextflow /opt/checkouts/nextflow.STABLE-22.10.x
cd /opt/checkouts/nextflow.STABLE-22.10.x
git checkout STABLE-22.10.x
cd -

# docker
sudo apt install docker-io # it needs superuser AND!!! add the user to the docker group (/etc/group) or docker-desktop
docker pull fischbachlab/nf-ninjamap:latest

# index
wget https://zenodo.org/record/7872423/files/hCom2_20221117.ninjaIndex.tar.gz
tar -pxvzf hCom2_20221117.ninjaIndex.tar.gz

# create symbolic link to data
# data must be in the same level of main-local.nf
ln -sf data/* .

# execute using nextflow 22.10.x
/opt/checkouts/nextflow.STABLE-22.10.x/nextflow run main-local.nf --reads1 read1.fastq.gz --reads2 read2.fastq.gz --db /opt/developing/nf-ninjamap.glucksfall/hCom2_20221117.ninjaIndex/HCom2_20221117 --db_prefix HCom2 --output_path local --coreNum 8 --memPerCore 2G -profile docker
