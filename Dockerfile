FROM mcr.microsoft.com/devcontainers/base:ubuntu

ARG USER=vscode

RUN DEBIAN_FRONTEND=noninteractive \
    && apt-get update \ 
    && apt-get upgrade -y \ 
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

# Install Rust using rustup
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="${HOME}/.cargo/bin:${PATH}"

RUN cargo install \
    cargo-audit \
    cargo-edit \
    cargo-fmt \
    cargo-make \
    cargo-outdated \
    cargo-tree \
    cargo-watch

# Install Python using pyenv
ARG PYTHON_VERSION=3.13
ENV PYENV_ROOT="${HOME}/.pyenv"
ENV PATH="${PYENV_ROOT}/shims:${PYENV_ROOT}/bin:${HOME}/.local/bin:$PATH"

RUN curl https://pyenv.run | bash
RUN pyenv install ${PYTHON_VERSION} && pyenv global ${PYTHON_VERSION}
RUN pip install uv

# Install User Packages
RUN cargo install \
    bat \
    fd-find \
    ripgrep \
    sd \
    starship \
    tealdeer \
    zellij

