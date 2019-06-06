# This dockerfile uses the ubuntu image
# VERSION 0.1
# Author: xliu <liuxin8166@bytedance.com>

FROM ubuntu:18.04
LABEL maintainer="liuxin8166@bytedance.com"

RUN buildDeps='curl vim locales gawk wget git-core diffstat unzip texinfo gcc-multilib \
     build-essential chrpath socat cpio rpm2cpio python python3 python3-pip python3-pexpect \
     xz-utils debianutils iputils-ping python3-git python3-jinja2 libegl1-mesa libsdl1.2-dev \
     ninja-build xterm locales' &&\
     apt-get update -y &&\
     apt-get install -y $buildDeps &&\
     apt-get autoremove -y

RUN  curl https://storage.googleapis.com/git-repo-downloads/repo > /usr/bin/repo &&\
     chmod a+x /usr/bin/repo &&\
     curl http://storage.googleapis.com/chromium-gn/3fd43e5e0dcc674f0a0c004ec290d04bb2e1c60e > /usr/bin/gn &&\
     chmod a+x /usr/bin/gn

RUN  locale-gen en_US.UTF-8 &&\
     echo 'root:1234' | chpasswd

ARG USER_NAME
ARG HOST_UID
ARG HOST_GID

RUN  groupadd ${USER_NAME} --force --gid ${HOST_GID} &&\
     useradd -l --uid ${HOST_UID} --gid ${HOST_GID} ${USER_NAME} &&\
     install -d -m 0755 -o ${USER_NAME} -g ${USER_NAME} /home/${USER_NAME} &&\
     chown --changes --silent --no-dereference --recursive ${HOST_UID}:${HOST_GID} /home/${USER_NAME}

USER ${USER_NAME}

# default workdir is /yocto
WORKDIR /yocto

# Set the locale, else yocto will complain
ENV DEBIAN_FRONTEND=noninteractive \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8

CMD ["bash"]