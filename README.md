docker-yocto
=================

## About

This [project](https://github.com/seigeweapon/docker-yocto) is forked from [coldnew/docker-yocto](https://github.com/coldnew/docker-yocto).

This repo contains docker image I use for building the yocto images.

I use the script yocto-build.sh to switch yocto building environment so I can use docker to build the [Yocto project](https://www.yoctoproject.org) instad of install a ubuntu as VM.

## Setting up

First copy yocto-build.sh to `~/bin/yocto-build`

```sh
mkdir -p ~/bin
cp yocto-build.sh ~/bin/yocto-build
chmod +x ~/bin/yocto-build
```

Add following line to the `~/.bashrc` file to ensure that the `~/bin` folder is in you PATH variable.

```sh
export PATH=~/bin:$PATH
```

Edit ~/bin/yocto-build, add postfix to CONTAINER name, making it unique, like:
```sh
CONTAINER="yocto-build-xliu"
```

## Basic Usage

First, check if the image has been built on this machine.
```sh
docker image ls | grep yocto-build
```

If not found, then build the docker image by simply do:
```sh
make
```

Note that this needs to be done ONLY ONCE.


First time to use the `yocto-build` command, you need to tell it where is the workdir we build the yocto image.

For example, if I want to build yocto at `/home/coldnew/poky` then:

```sh
yocto-build --workdir /home/coldnew/poky
```

After this command, we'll create a container named `yocto-build`, which is the environment we used to build the yocto image.
Now you'll find your current shell is switch to the container and the `/home/coldnew/poky` is mounted to `/yocto`.

## Spawn a new shell

If you want to spawn a new shell in another terminal, you can use

```sh
yocto-build --shell
```

This will spawn a new shell if you already specify a workdir.

## Remove the container

This script supports *ONLY ONE CONTAINER* per user, so If you want to change the workdir, you should remove it first, remove a container is easy, just use following command:

```sh
yocto-build --rm
```

Then you can setup a new workdir you want.

## Upgrade script

Upgrade this script is easy, just type

```sh
yocto-build --upgrade
```
