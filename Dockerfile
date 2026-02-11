FROM ubuntu:latest AS builder

ENV LAZYGIT_VERSION="0.59.0"
ENV GO_VERSION="1.24.0"
ENV NVIM_VERSION="v0.11.6"

RUN apt update && \
	apt-get install -y curl wget

# install go lang
RUN wget https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz && \
	rm -rf /usr/local/go && \
	tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz

# install lazygit
RUN curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz" && \
	tar xf lazygit.tar.gz lazygit && \
	install lazygit -D -t /usr/local/bin/

# install nvim
RUN wget "https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}/nvim-linux-x86_64.tar.gz" && \
	tar -C /usr/local -xzf nvim-linux-x86_64.tar.gz && \
	rm -f nvim-linux-x86_64.tar.gz

FROM ubuntu:latest

ARG USERNAME=nvimuser
ARG USER_UID=1000
ARG USER_GID=1000

COPY --from=builder /usr/local/go /usr/local/go
COPY --from=builder /usr/local/bin/lazygit /usr/local/bin/lazygit
COPY --from=builder /usr/local/nvim-linux-x86_64 /usr/local/nvim-linux-x86_64

RUN apt update && apt-get install -y \
	build-essential \
	python3 \
	python3-dev \
	python3-pip \
	python3-venv \
	curl \
	openjdk-21-jdk \
	git \
	fzf \
	curl \
	wget \
	zsh \
	zsh-autosuggestions \
	zsh-syntax-highlighting \
	ripgrep \
	lua5.3 \
	lua5.3-dev \
	luarocks \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt-get install -y \
	nodejs \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENV ZSH=/usr/local/zsh
ENV TERM=xterm

# Default powerline10k theme, no plugins installed
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
RUN git clone https://github.com/zsh-users/zsh-autosuggestions /usr/local/zsh/custom/plugins/zsh-autosuggestions

RUN userdel -r ubuntu || true \
    && groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m -s /usr/bin/zsh ${USERNAME}

RUN chmod -R go-w /usr/local/zsh
RUN chown -R ${USERNAME}:${USERNAME} /usr/local/zsh

RUN npm install -g @google/gemini-cli

USER ${USERNAME}
WORKDIR /home/${USERNAME}

ENV PATH=$PATH:/usr/local/go/bin:/usr/local/nvim-linux-x86_64/bin
# COPY nvim/config /root/.config/nvim
