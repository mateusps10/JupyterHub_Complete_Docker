FROM continuumio/miniconda3

# Create conda env with jupyterhub
RUN conda config --add channels conda-forge
RUN conda config --set channel_priority strict
RUN conda update --all
RUN conda create -n env anaconda jupyterhub pyspark oauthenticator
RUN conda update -n base -c defaults conda
RUN echo "source activate env" > ~/.bashrc
ENV PATH /opt/conda/envs/env/bin:$PATH

# Import jupyterhub users
COPY jupyterhub_config.py /

# Create script for container startup
COPY docker-entrypoint.sh /opt/conda/envs/env/bin/
RUN ln -s usr/local/bin/docker-entrypoint.sh / # backwards compat
ENTRYPOINT ["docker-entrypoint.sh"]
