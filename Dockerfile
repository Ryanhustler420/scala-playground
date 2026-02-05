FROM jupyter/base-notebook:python-3.11

USER root

# Install Java + curl (needed for coursier)
RUN apt-get update && \
    apt-get install -y \
      openjdk-17-jre \
      curl \
      gzip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

USER ${NB_UID}

# # Install coursier (ARM-compatible)
# RUN curl -fL https://github.com/coursier/launchers/raw/master/cs-aarch64-pc-linux.gz \
#     | gzip -d > cs && \
#     chmod +x cs && \
#     ./cs setup -y

# Install coursier
RUN curl -fL https://github.com/coursier/launchers/raw/master/cs-x86_64-pc-linux.gz \
    | gzip -d > cs && \
    chmod +x cs && \
    ./cs setup -y

ENV PATH="/home/jovyan/.local/share/coursier/bin:${PATH}"

# Install Almond (Scala kernel)
RUN cs install almond && \
    almond --install
