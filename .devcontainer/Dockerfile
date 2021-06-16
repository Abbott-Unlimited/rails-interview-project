# [Choice] Ruby version: 2, 2.7, 2.6, 2.5
ARG VARIANT=2
FROM mcr.microsoft.com/vscode/devcontainers/ruby:${VARIANT}

# [Option] Install Node.js
ARG INSTALL_NODE="false"
ARG NODE_VERSION="lts/*"
RUN if [ "${INSTALL_NODE}" = "true" ]; then \
  su vscode -c "umask 0002 && . /usr/local/share/nvm/nvm.sh && nvm install ${NODE_VERSION} 2>&1" \
  ; fi

ARG INSTALL_YARN="false"
RUN if [ "${INSTALL_YARN}" = "true" ]; then \
  npm install --global yarn \
  ; fi

# Update lists
RUN apt -y update && apt -y upgrade

# Install git, process tools
RUN apt -y install git procps

# Install SQLite3
RUN apt -y install sqlite3

# Clean up
RUN apt autoremove -y \
  && apt clean -y \
  && rm -rf /var/lib/apt/lists/*

# Set the default shell to bash instead of sh
ENV SHELL /bin/bash
