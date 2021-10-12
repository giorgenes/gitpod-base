FROM gitpod/workspace-base:latest

# hashicorp packer
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
RUN sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

# docker
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
RUN sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

RUN sudo apt-get update \
    && sudo apt-get install -y gnupg software-properties-common curl git dirmngr gpg gawk \
    linux-headers-$(uname -r) build-essential procps file libreadline-dev zlib1g-dev \
    packer \
    zsh \
    httpie \
    docker-ce docker-ce-cli containerd.io \
    && sudo rm -rf /var/lib/apt/lists/*

# docker 
USER root
RUN curl -o /usr/bin/slirp4netns -fsSL https://github.com/rootless-containers/slirp4netns/releases/download/v1.1.12/slirp4netns-$(uname -m) \
    && chmod +x /usr/bin/slirp4netns
RUN curl -o /usr/local/bin/docker-compose -fsSL https://github.com/docker/compose/releases/download/1.29.2/docker-compose-Linux-x86_64 \
    && chmod +x /usr/local/bin/docker-compose 
USER gitpod

# homebrew
# ENV TRIGGER_BREW_REBUILD=2
# RUN mkdir ~/.cache && /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# ENV PATH=$PATH:/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin/
# ENV MANPATH="$MANPATH:/home/linuxbrew/.linuxbrew/share/man"
# ENV INFOPATH="$INFOPATH:/home/linuxbrew/.linuxbrew/share/info"
# ENV HOMEBREW_NO_AUTO_UPDATE=1
# RUN sudo apt remove -y cmake \
#     && brew install cmake
# RUN echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> $HOME/.bashrc.d/homebrew.sh

# hygen
# RUN bash -ic "brew tap jondot/tap"
# RUN bash -ic "brew install hygen"

RUN git clone https://github.com/asdf-vm/asdf.git $HOME/.asdf --branch v0.8.1

RUN echo ". $HOME/.asdf/asdf.sh" >> $HOME/.bashrc.d/asdf.sh
RUN echo ". $HOME/.asdf/completions/asdf.bash" >> $HOME/.bashrc.d/asdf.sh

ENV BUMP_TO_FORCE_GITPOD_UPDATE=4
COPY install-asdf-plugins.sh $HOME/
RUN ./install-asdf-plugins.sh

# ZSH
ENV ZSH_THEME cloud
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
COPY zsh-template.sh $HOME/.zshrc


# install ansible
#RUN bash -ic "python -m pip install --user ansible"
#RUN bash -ic "python -m pip install --user paramiko"

ONBUILD COPY .tool-versions $HOME/
ONBUILD RUN bash -c ". $HOME/.bashrc.d/asdf.sh && asdf install"

CMD [ "zsh" ]
