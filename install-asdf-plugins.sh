#!/bin/bash

. $HOME/.bashrc.d/asdf.sh
asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git
asdf plugin-add golang https://github.com/kennyp/asdf-golang.git
asdf plugin-add python
asdf plugin add awscli
asdf plugin add terraform
asdf plugin add sops
asdf plugin-add java
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git 
asdf plugin-add postgres
asdf plugin-add elasticsearch https://github.com/asdf-community/asdf-elasticsearch.git

