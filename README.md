[![Gitpod ready-to-code](https://img.shields.io/badge/Gitpod-ready--to--code-908a85?logo=gitpod)](https://gitpod.io/#https://github.com/giorgenes/gitpod-base)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](/LICENSE)


# About

A base gitpod image with ASDF and ZSH

By default it installs the following:

* ASDF
* httpie
* gpg
* build-essential
* packer
* zsh and ohmyzsh
* docker

# How to use

Make sure you have a `.tool-versions` ASDF file in your root directory then add this to your `.gitpod.Dockerfile` file:

```docker
FROM giorgenes/gitpod-base
```

# Local development

Build the image:

```bash
docker build . -t giorgenes/gitpod-base
```

Push it:

```bash
docker login --username=giorgenes
docker push giorgenes/gitpod-base:tagname
```
