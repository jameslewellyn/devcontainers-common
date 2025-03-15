FROM mcr.microsoft.com/devcontainers/base:ubuntu

ARG USER=vscode

RUN DEBIAN_FRONTEND=noninteractive \
    && apt-get update \ 
    && apt-get install -y \
    build-essential \
    ca-certificates \
    curl \
    git \
    libbz2-dev \
    libffi-dev \
    liblzma-dev \
    libncurses5-dev \
    libreadline-dev \
    libsqlite3-dev \
    libssl-dev \
    libxml2-dev \
    libxmlsec1-dev \
    llvm \
    sudo \
    tk-dev \
    wget \
    x11-apps \
    xz-utils \
    zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

USER $USER
ARG HOME="/home/$USER"
ARG PYTHON_VERSION=3.13

ENV PYENV_ROOT="${HOME}/.pyenv"
ENV PATH="${PYENV_ROOT}/shims:${PYENV_ROOT}/bin:${HOME}/.local/bin:$PATH"

RUN curl https://pyenv.run | bash
RUN pyenv install ${PYTHON_VERSION} && pyenv global ${PYTHON_VERSION}
RUN pip install uv
