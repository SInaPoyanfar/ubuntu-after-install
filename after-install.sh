#!/bin/bash

# check for user as root
if ! [ $(id -u) = 0 ]; then
   echo "The script need to be run as root." >&2
   exit 1
fi

if [ $SUDO_USER ]; then
    real_user=$SUDO_USER
else
    real_user=$(whoami)
fi

# read user git details
read -sp 'git username: ' git_username
read -sp 'git useremail: ' git_useremail

# updating cores
apt update
apt upgrade -y
snap refresh

# install additional things 
apt install ubuntu-restricted-extras -y
apt install apt-transport-https curl

# git and config
apt install git -y
git config --global user.name "${git_username}"
git config --global user.email "${git_useremail}"
echo "\033[43m \033[30m you need to add gpg and ssh key manually. \033[0m"

# programming stuff
apt install gcc g++ -y
apt install vim -y
sudo apt-get install python-software-properties -y
apt install python3-pip -y
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt-get install -y nodejs

# proxy stuff
apt install privoxy -y
# TODO: add config later
apt install shadowsocks -y
# todo: check for errors

# installing vscode
# TODO: search about extensions installation with commandline
# ToDO: search about were global config is saved 
snap install code --classic

# installing browsers
snap install brave
snap install chromium

apt install unzip

# installig zsh and oh-my-zsh with hack font
apt install zsh -y
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# TODO: config zsh later
chsh -s $(which zsh)
curl -o /tmp/fonts/x-hack.tar.gz https://github.com/source-foundry/Hack/releases/download/v3.003/Hack-v3.003-ttf.tar.gz
tar -xzf /tmp/fonts/x-hack.tar.gz 
mkdir ~/.fonts
mv /tmp/fonts/hack* ~/.fonts/ 
fc-cache -f -v

# installing player
snap install --beta mpv 

# installing tweak
apt install gnome-tweak-tool -y 
# TODO: install extenstions

# installing social medias
snap install telegram-desktop --classic
snap install rambox
snap install discord

# installing android studio
snap install android-studio --classic
