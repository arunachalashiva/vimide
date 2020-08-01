FROM ubuntu:bionic

MAINTAINER ArunachalaShiva

WORKDIR /root/work

RUN mkdir /usr/local/share/vim

# Install tools
RUN apt-get update \
 && apt-get install -y vim curl unzip git wget

# Install python
RUN apt-get install -y python3.6 python3-setuptools python3-pip python3-dev virtualenv \
 && ln -s /usr/bin/python3.6 /usr/bin/python \
 && ln -s /usr/bin/pip3 /usr/bin/pip
RUN pip install jedi flake8 autopep8 yapf

# Install C and C++
RUN apt-get install -y gcc g++ build-essential clang clang-tidy clang-format cmake

# Install java and mvn
RUN apt-get install -y openjdk-8-jdk
RUN apt-get install -y maven
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ENV PATH=${PATH}:/usr/local/bin:${JAVA_HOME}/bin
RUN wget https://github.com/google/google-java-format/releases/download/google-java-format-1.6/google-java-format-1.6-all-deps.jar -P /usr/local/share/vim/
RUN wget https://repo1.maven.org/maven2/org/projectlombok/lombok/1.18.8/lombok-1.18.8-sources.jar -P /usr/local/share/vim
RUN wget https://repo1.maven.org/maven2/org/projectlombok/lombok/1.18.8/lombok-1.18.8.jar -P /usr/local/share/vim

# Install go
RUN curl -sL --retry 5 "https://dl.google.com/go/go1.14.2.linux-amd64.tar.gz" \
    | gunzip | tar -x -C /usr/local/
ENV GOPATH=/root/work/go
ENV PATH=${PATH}:/usr/local/go/bin:${GOPATH}/bin
RUN go get golang.org/x/tools/cmd/goimports

# Download vundle and install all vim plugins using vundle
RUN git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
COPY vimrc /root/.vimrc
RUN vim +silent +PluginInstall +qall
RUN cd /root/.vim/bundle/YouCompleteMe \
 && python3 ./install.py --java-completer --clangd-completer --go-completer \
 && cd -
COPY ftplugin /root/.vim/ftplugin/
COPY ycm_extra_conf.py /root/.vim/.ycm_extra_conf.py
COPY google-java-format /usr/local/bin/

# Install FZF and RipGrep
RUN git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf \
 && ~/.fzf/install \
 && wget -O rg.deb https://github.com/BurntSushi/ripgrep/releases/download/11.0.2/ripgrep_11.0.2_amd64.deb \
 && dpkg -i rg.deb \
 && rm rg.deb
ENV PATH=${PATH}:/root/.fzf/bin

RUN apt-get install -y locales \
 && locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

CMD ["/usr/bin/vim"]
