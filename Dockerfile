FROM quay.io/jupyter/base-notebook
RUN sudo apt-get install -y vim git
RUN mamba install --yes 'flake8' && \
    mamba clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

# Install from the requirements.txt file
RUN cd "/home/${NB_USER}"; git clone https://github.com/iaa-so-training/basic-neural-network-2023
COPY --chown=${NB_UID}:${NB_GID} environment.yml /tmp/
RUN mamba install --yes --file /tmp/environment.yml && \
    mamba clean --all -f -y && \
    conda activate iaa_nn && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"
