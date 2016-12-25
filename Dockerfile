FROM ubuntu:16.04

RUN rm /bin/sh && ln -s /bin/bash /bin/sh


RUN apt-get -y update && apt-get -y upgrade
RUN apt-get -y install build-essential libssl-dev curl rsync git tmux

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb http://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get -y update && apt-get -y install yarn

ENV NODE_VERSION 6.9.2
ENV NVM_VERSION 0.32.1
ENV NVM_DIR /root/.nvm

RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v$NVM_VERSION/install.sh | bash \
    && source $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION

ENV NODE_PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin
ENV PATH $NODE_PATH:$PATH

RUN mkdir /opt/dev