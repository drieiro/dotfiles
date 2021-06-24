#!/bin/bash

dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"


#######################################################################################


# Installation functions
install_i3 () {
    sudo apt update &>/dev/null
    sudo apt install -y i3 compton dunst py3status rofi libnotify-bin playerctl pavucontrol xbacklight feh network-manager-gnome nautilus-dropbox xdo xdotool arandr xclip lxappearance clipit unclutter-xfixes
}

install_nerdfont () {
    if fc-list | grep -q 'Roboto Mono Nerd Font'; then
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
}

install_git () {
    command -v git &>/dev/null || sudo apt install git

    curl -s https://api.github.com/repos/so-fancy/diff-so-fancy/releases/latest \
    | grep "browser_download_url" \
    | grep "diff-so-fancy" \
    | awk '{print $2}' \
    | tr -d \" \
    | xargs wget -O $HOME/.local/bin/diff-so-fancy \
    && chmod +x $HOME/.local/bin/diff-so-fancy

    git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
}

install_mpv () {
    command -v mpv &>/dev/null || sudo apt install mpv

    ## mpv-mpris
    curl -s https://api.github.com/repos/hoyon/mpv-mpris/releases/latest \
    | grep "browser_download_url" \
    | grep ".so\"" \
    | awk '{print $2}' \
    | tr -d \" \
    | xargs wget -O $HOME/.config/mpv/scripts/mpris.so
}

install_evince () {
    if command -v evince &>/dev/null; then
        sudo ln -s /etc/apparmor.d/usr.bin.evince /etc/apparmor.d/disable/usr.bin.evince
        sudo /etc/init.d/apparmor restart
    fi
}

install_pynvim () {
    sudo apt-get install -y python3-pip
    python3 -m pip install pynvim
}

install_oh-my-zsh () {
    [ ! -d $HOME/.oh-my-zsh ] && sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

install_X11 () {
    bash $dir/X11/install.sh
}


#######################################################################################


read -rp "Make preinstallation? [y/n]: " preinstallation

if [ "$preinstallation" = "y" ]; then
    install_i3
    install_nerdfont
    install_git
    install_mpv
    install_evince
    install_pynvim
    install_oh-my-zsh
    install_X11
fi

# Manage dotfiles
command -v stow &>/dev/null || sudo apt install -y stow &>/dev/null
# stow -v --adopt tmux
stow -v --adopt alacritty
stow -v --adopt compton
stow -v --adopt dunst
stow -v --adopt git
stow -v --adopt i3
stow -v --adopt misc
stow -v --adopt mpv
stow -v --adopt newsboat
stow -v --adopt nvim
stow -v --adopt py3status
stow -v --adopt rofi
stow -v --adopt shell
stow -v --adopt wget
