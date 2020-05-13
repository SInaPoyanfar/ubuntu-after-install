#!/bin/bash

read -p 'Enter your Ubuntu username: ' user
export CURRENT_USER=$user

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
read -p 'git username: ' git_username
read -p 'git useremail: ' git_useremail

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
echo -e "\033[43m \033[30m you need to add gpg and ssh key manually. \033[0m"

# programming stuff
apt install gcc g++ -y
apt install vim -y
apt install python3-pip -y
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt-get install -y nodejs

# proxy stuff
apt install privoxy -y
mv /etc/privoxy/config /etc/privoxy/config.bak
cp -v ./configs/privoxy/config /etc/privoxy/config
pip3 install shadowsocks
apt install proxychains
mv /etc/proxychains.conf /etc/proxychains.conf.bak
cp ./configs/proxychains/proxychains.conf /etc/proxychains.conf

# installing vscode
snap install code --classic
sh ./configs/vscode/extensions.sh 
mv /home/$user/.config/Code/User/settings.json /home/$user/.config/Code/User/settings.json.bak
cp -v ./configs/vscode/settings.json /home/$user/.config/Code/User/settings.json

# installing browsers
snap install brave
snap install chromium

apt install unzip

# installig zsh with hack font
apt install zsh -y
chsh -s $(which zsh)
curl -o /tmp/fonts/x-hack.tar.gz https://github.com/source-foundry/Hack/releases/download/v3.003/Hack-v3.003-ttf.tar.gz
tar -xzf /tmp/fonts/x-hack.tar.gz 
mkdir /home/$user/.fonts
mv /tmp/fonts/hack* /home/$user/.fonts/ 
fc-cache -f -v
git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git /home/$user/zsh-syntax-highlighting
mv /home/$user/.zshrc /home/$user/.zshrc.bak
cp ./configs/zsh/zshrc /home/$user/.zshrc 

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

# installing variety
add-apt-repository ppa:peterlevi/ppa -y
apt install variety -y

apt autoclean
apt autoclear

echo -e "\033[43m \033[30m for affective and make zsh your permanent shell reboot your system. \033[0m"

# lastly oh-my-zsh 
sudo -u $user sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo -e "\033[43m \033[30m for affective and make zsh your permanent shell reboot your system. \033[0m"