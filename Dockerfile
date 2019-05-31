# This dockerfile uses the ubuntu image
# VERSION 0 - EDITION 1
# Author:  Yen-Chin, Lee <yenchin@weintek.com>
#          xliu <liuxin8166@bytedance.com>
# Command format: Instruction [arguments / command] ..

FROM ubuntu:18.04
LABEL maintainer="liuxin8166@bytedance.com"

## Install requred packages, and configuration:
# 1. Essentials from http://www.yoctoproject.org/docs/current/ref-manual/ref-manual.html
# 2. google repo tool
# 3. gn tool
# 4. give root password

RUN buildDeps='curl vim locales gawk wget git-core diffstat unzip texinfo gcc-multilib \
     build-essential chrpath socat cpio rpm2cpio python python3 python3-pip python3-pexpect \
     xz-utils debianutils iputils-ping python3-git python3-jinja2 libegl1-mesa libsdl1.2-dev \
     ninja-build xterm apt-utils sudo' \
     && apt-get update -y \
     && apt-get install -y $buildDeps \
     && curl https://storage.googleapis.com/git-repo-downloads/repo > /usr/bin/repo \
     && chmod a+x /usr/bin/repo \
     && curl http://storage.googleapis.com/chromium-gn/3fd43e5e0dcc674f0a0c004ec290d04bb2e1c60e > /usr/bin/gn \
     && chmod a+x /usr/bin/gn \
     && locale-gen en_US.UTF-8 \
     && apt-get autoremove -y \
     && echo 'root:1234' | chpasswd \
     && echo 'xliu:1234' | chpasswd

# Set the locale, else yocto will complain
ENV DEBIAN_FRONTEND=noninteractive \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8

# default workdir is /yocto
WORKDIR /yocto

# Add entry point, we use entrypoint.sh to mapping host user to
# container
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
