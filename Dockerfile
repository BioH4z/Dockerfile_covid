FROM biohaz/basic_ubuntu:latest

# Locale for click
ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8

# Install conda
RUN wget -q https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/miniconda3.sh
RUN /bin/bash /tmp/miniconda3.sh -bp /opt/miniconda3
RUN rm /tmp/miniconda3.sh

# Update conda and install conda-build
RUN /opt/miniconda3/bin/conda update -yq conda
RUN /opt/miniconda3/bin/conda install -yq conda-build

# Set conda environment
RUN echo "export PATH=/opt/miniconda3/bin:$PATH" > /etc/profile
ENV PATH /opt/miniconda3/bin:$PATH

#Install required tools
RUN apt-get update -y \
	&& apt-get install -y fastqc bwa\
	&& pip3 install cutadapt multiqc

RUN conda create -n megahit -c bioconda megahit \
	&& conda create -n samtools -c bioconda samtools bcftools\
	&& conda create -n freebayes -c bioconda freebayes=1.3.2 \
	&& conda create -n snippy -c biobuilds snippy
