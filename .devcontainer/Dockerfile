# [Choice] Ruby version: 2, 2.7, 2.6, 2.5
ARG VARIANT=2
FROM mcr.microsoft.com/vscode/devcontainers/ruby:${VARIANT}

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
