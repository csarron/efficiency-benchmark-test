FROM nvidia/cuda:11.6.2-cudnn8-devel-ubuntu20.04

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

# Install base utilities
RUN apt-get update \
    && apt-get install -y wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install miniconda
ENV CONDA_DIR /opt/conda

RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
     /bin/bash ~/miniconda.sh -b -p /opt/conda

# Put conda in path so we can use conda activate
ENV PATH=$CONDA_DIR/bin:$PATH

RUN conda update -n base -c defaults conda

WORKDIR /stage/

COPY env.yaml .

# COPY src src

RUN conda env create -f env.yaml

# # for interactive session
# RUN chmod -R 777 /stage/
