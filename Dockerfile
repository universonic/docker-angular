# universonic/angular-el7
# Version: 1.0.0
# Author:  Alfred Chou <unioverlord@gmail.com>

FROM centos:latest AS node_centos

# Change the following parameters as you wish.
ARG NODE_VERSION=6.12.2
ARG NODE_PACKAGE_SOURCE=https://rpm.nodesource.com/pub_6.x/el/7/x86_64/nodejs-6.12.2-1nodesource.x86_64.rpm
ARG VENDOR_NAME="Red Hat, Inc."

USER root

# Install dependencies for Node.js
RUN yum -y install make gcc-c++

# Setup node and npm
RUN set -eux; \
    yum -y install wget git && yum -y clean all; \
    yum -y install ${NODE_PACKAGE_SOURCE} && yum -y clean all; \
    useradd -d /datastore node; \
    chown -R node:root /usr/lib/node_modules; \
    chmod -R 775 /usr/lib/node_modules; \
    npm install -g @angular/cli

# Setup node environments
USER node
WORKDIR /datastore

# Specify image metadatas
LABEL vendor ${VENDOR_NAME}
LABEL architecture x86_64
LABEL version ${NODE_VERSION}
LABEL summary Platform for building and running Node.js ${NODE_VERSION} applications
LABEL description Node.js ${NODE_VERSION} available as docker container is a base platform for building and running various Node.js ${GOLANG_VERSION} applications and frameworks.
LABEL distribution-scope public
LABEL io.openshift.tags builder,nodejs,nodejs-${NODE_VERSION}
LABEL io.k8s.description Platform for building and running Node.js ${NODE_VERSION} applications
LABEL io.k8s.display-name Node.js ${NODE_VERSION}

# Build image with command: 'docker build --rm --squash . -t <YOUR_REPOSITORY>:<NODE_VERSION> -t <YOUR_REPOSITORY>:latest'
