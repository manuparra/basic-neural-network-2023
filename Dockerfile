FROM jupyter/base-notebook:python-3.7.6
USER root

# apt-get may result in root-owned directories/files under $HOME
RUN chown -R $NB_UID:$NB_GID $HOME

ADD . /opt/install
RUN fix-permissions /opt/install

USER $NB_USER

RUN cd /opt/install && \
    conda env update -n base --file environment.yml && \
    mv /opt/conda/.condarc /opt/conda/.condarc.bak && \
    wget --output-document basic-neural-network-2023.env.yml https://github.com/manuparra/basic-neural-network-2023/blob/main/environment.yml && \
    conda env update -n base --file basic-neural-network-2023.env.yml && \
    conda install --yes -c conda-forge nbgitpuller git && \
    conda clean --all --yes
