#!/bin/bash

mkdir ~/workspace_mine/
mkdir ~/workspace_misc/

. ~/dotfiles/apt-key/set-to-machine.sh

# install essential tools
sudo apt install -y git zsh curl zsh tmux google-chrome-stable emacs26 rofi ruby \
     gdebi apt-transport-https sublime-merge dconf-editor gnome-tweak-tool code \
     xdotool tree p7zip-full pavucontrol indicator-sound-switcher ibus-unikey \
     blueman neovim \
     libx11-dev apt-file libxdamage-dev libxrender-dev libxext-dev # requires to compile find-cursor

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# after this, should restart to change shell to zsh

# install exa
# ref https://ourcodeworld.com/articles/read/832/how-to-install-and-use-exa-a-modern-replacement-for-the-ls-command-in-ubuntu-16-04
## install rust compiler
curl https://sh.rustup.rs -sSf | sh

## TODO: find a way to fetch latest binary
wget -c https://github.com/ogham/exa/releases/download/v0.8.0/exa-linux-x86_64-0.8.0.zip
unzip exa-linux-x86_64-0.8.0.zip && rm exa-linux-x86_64-0.8.0.zip
sudo mv exa-linux-x86_64 /usr/local/bin/exa

# install nerd font
git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git &&
  nerd-fonts/install.sh &&
  mv nerd-fonts ~/workspace_misc/

# install find-cursor
git clone https://github.com/arp242/find-cursor.git && cd find-cursor &&
    make && sudo make install && cd .. && mv find-cursor ~/workspace_misc/

# install alacritty
sudo apt install alacritty
ln -sf $(realpath ~/dotfiles/alacritty.yml) ~/.config/alacritty/

# rofi
mkdir -p ~/.config/rofi/
ln -sf $(realpath ~/dotfiles/rofi/config.rasi) ~/.config/rofi/

# install snap packages
sudo snap install hub --classic

# install discord
wget --content-disposition https://discordapp.com/api/download\?platform\=linux\&format\=deb
sudo gdebi discord*.deb

# install caprine
curl -s https://api.github.com/repos/sindresorhus/caprine/releases/latest \
| grep "browser_download_url.*deb" \
| cut -d : -f 2,3 \
| tr -d \" \
| wget -i -

# install slack

# install spotify, cause we already add gpg key of its server, then just apt install
sudo apt-get install spotify-client

# install gnome-extensions
mkdir -p ~/.local/share/gnome-shell/extensions

## unite
## https://extensions.gnome.org/extension/1287/unite/
## gtile
## https://extensions.gnome.org/extension/28/gtile/

# big fat heavy packages
sudo apt install -y kicad

# some misc command
## enable control nvidia-card-fan-speed
## sudo nvidia-xconfig -a --cool-bits=28

# install grc
git clone git@github.com:zealotnt/grc.git && mv grc ~/workspace_misc/ && cd ~/workspace_misc/grc && sudo ./install.sh && cd

# install kubectl
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl &&
    chmod 777 kubectl && sudo mv kubectl /usr/local/bin

# install kubectl-krew
(
  set -x; cd "$(mktemp -d)" &&
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/download/v0.3.2/krew.{tar.gz,yaml}" &&
  tar zxvf krew.tar.gz &&
  ./krew-"$(uname | tr '[:upper:]' '[:lower:]')_amd64" install \
    --manifest=krew.yaml --archive=krew.tar.gz
)
# kubectl, kubens
kubectl krew install ctx
kubectl krew install ns

# install prometheus
curl -s https://api.github.com/repos/prometheus/prometheus/releases/latest \
| grep "browser_download_url.*linux-amd64.tar.gz" \
| cut -d : -f 2,3 \
| tr -d \" \
| wget -i -


# vietnamese typing
# basically, dconf already setup the neccessary configuration for vietnamese typing
# but things still need to be configured correctly
# follow settings -> Region & Language -> Language -> {ubuntu will prompt to install the missing pieces}

