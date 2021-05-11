#!/bin/bash

dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

read -rp "Make preinstallation? [y/n]: " preinstallation

if [ "$preinstallation" = "y" ]; then
	## Preinstallation 

	# i3 installation
	sudo apt update &>/dev/null
	sudo apt install -y i3 compton dunst py3status rofi libnotify-bin playerctl pavucontrol xbacklight feh network-manager-gnome nautilus-dropbox xdo xdotool 

	# Nerd font
	if $(fc-list | grep -q 'Roboto Mono Nerd Font'); then
	    echo "Roboto Mono Nerd Font is already installed."
	else
	    curl -s https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest \
	    | grep "browser_download_url" \
	    | grep "RobotoMono.zip" \
	    | awk '{print $2}' \
	    | tr -d \" \
	    | xargs wget -O /tmp/RobotoMono.zip \
	    && sudo unzip /tmp/RobotoMono.zip -d /usr/share/fonts/truetype/roboto_mono_nerd_font
	fi


	# Git installation
	command -v git &>/dev/null || sudo apt install git
	if grep -q 'diff-so-fancy' $dir/git/.gitconfig ; then
	    [ ! -d /opt/diff-so-fancy ] && sudo git clone https://github.com/so-fancy/diff-so-fancy.git /opt/diff-so-fancy
	    sudo ln -svf /opt/diff-so-fancy/diff-so-fancy /usr/local/bin/diff-so-fancy
	    git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
	fi


	# mpv installation
	command -v mpv &>/dev/null || sudo apt install mpv

	[ ! -d ${SC:-$HOME/.local/scripts} ] && mkdir ${SC:-$HOME/.local/scripts} 
	[ ! -d $HOME/.config/mpv ] && mkdir $HOME/.config/mpv
	ln -svf $dir/misc/mpvsi ${SC/mpvsi:-$HOME/.local/scripts/mpvsi}
	sudo ln -svf $dir/misc/mpv.desktop /usr/share/applications/mpv.desktop

	# Plugins
	[ ! -d $HOME/.config/mpv/scripts ] && mkdir $HOME/.config/mpv/scripts

	## SponsorblockMinimal
	sudo git clone https://codeberg.org/jouni/mpv_sponsorblock_minimal.git /opt/mpv_sponsorblock_minimal
	ln -s /opt/mpv_sponsorblock_minimal/sponsorblock_minimal.lua $HOME/.config/mpv/scripts/sponsorblock_minimal.lua

	## mpv-youtube-quality
	sudo git clone https://github.com/jgreco/mpv-youtube-quality.git /opt/mpv-youtube-quality
	ln -s /opt/mpv-youtube-quality/youtube-quality.lua $HOME/.config/mpv/scripts/youtube-quality.lua
	sudo sed -i 's/select_binding = "ENTER",/select_binding = "SPACE",/g' /opt/mpv-youtube-quality/youtube-quality.lua

	## mpv-mpris
	curl -s https://api.github.com/repos/hoyon/mpv-mpris/releases/latest \
	| grep "browser_download_url" \
	| grep ".so\"" \
	| awk '{print $2}' \
	| tr -d \" \
	| xargs wget -O $HOME/.config/mpv/scripts/mpris.so


	# Evince config to enable links with Brave
	if command -v evince &>/dev/null; then
	sudo ln -s /etc/apparmor.d/usr.bin.evince /etc/apparmor.d/disable/usr.bin.evince
	sudo /etc/init.d/apparmor restart
	fi


	# Pynvim
	sudo apt-get install -y python3-pip
	python3 -m pip install pynvim


	# Oh-my-zsh
	[ ! -d $HOME/.oh-my-zsh ] && sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


	# X11
	bash $dir/X11/install.sh
fi

## Manage dotfiles
command -v stow &>/dev/null || sudo apt install -y stow
stow -v --adopt alacritty
stow -v --adopt compton
stow -v --adopt dunst
stow -v --adopt git
stow -v --adopt i3
stow -v --adopt mpv
stow -v --adopt newsboat
stow -v --adopt py3status
stow -v --adopt rofi
stow -v --adopt shell
stow -v --adopt tmux
stow -v --adopt vim
#stow -v --adopt vscode
stow -v --adopt wget
