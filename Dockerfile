FROM node:latest

RUN apt update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y \
    chromium \
    firefox-esr \
    xvfb

RUN curl -o- -L https://yarnpkg.com/install.sh | bash

WORKDIR /app

ONBUILD ADD . /app
ONBUILD RUN $HOME/.yarn/bin/yarn install --pure-lockfile
