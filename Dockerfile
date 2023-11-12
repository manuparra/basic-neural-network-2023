FROM jupyter/base-notebook:python-3.7.6
USER root

# apt-get may result in root-owned directories/files under $HOME
RUN chown -R $NB_UID:$NB_GID $HOME

ADD . /opt/install
RUN fix-permissions /opt/install

USER $NB_USER

RUN cd /opt/install
RUN cd /opt/install; conda env update -n base --file environment.yml
RUN mv /opt/conda/.condarc /opt/conda/.condarc.bak
RUN conda install --yes -c conda-forge nbgitpuller git 
RUN conda clean --all --yes
