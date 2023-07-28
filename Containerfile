FROM docker.io/debian:11.3
LABEL authors="Kosmas Hench" \
      description="Container containing common population genetic software"

# setting up conda
RUN apt update && apt install -y wget procps
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-py39_4.12.0-Linux-x86_64.sh && \
    bash Miniconda3-py39_4.12.0-Linux-x86_64.sh -b -p /miniconda

ENV PATH ${PATH}:/miniconda/bin

# install mamba for fast installation and set up channels
RUN conda install mamba=1.4.9 -y -n base -c conda-forge
RUN conda config --add channels defaults && \
    conda config --add channels bioconda && \
    conda config --add channels conda-forge

# install packages available via conda
COPY env.yml /
RUN mamba env create -f /env.yml && conda clean -a

RUN apt install -y git gcc make libz-dev libbz2-dev liblzma-dev libcurl4-gnutls-dev libgsl-dev
RUN mkdir -p /manual_install/bin && \
    cd /manual_install && \
    git clone https://github.com/simonhmartin/genomics_general.git && \
    cd ../bin && \
    echo '#!/usr/bin/env bash'"\npython3.11 /manual_install/genomics_general/VCF_processing/parseVCF.py "'$@' > parseVCF && \
    chmod 755 parseVCF && \
    echo '#!/usr/bin/env bash'"\npython3.11 /manual_install/genomics_general/popgenWindows.py "'$@' > popgenWindows && \
    chmod 755 popgenWindows

ENV PATH ${PATH}:/miniconda/envs/popgen_suite/bin:/manual_install/bin