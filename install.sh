#!/bin/bash

dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"


#######################################################################################


# Installation functions
install_i3 () {
    sudo apt update &>/dev/null
    sudo apt install -y i3 compton dunst py3status rofi libnotify-bin playerctl pavucontrol xbacklight feh network-manager-gnome nautilus-dropbox xdo xdotool arandr xclip lxappearance clipit unclutter-xfixes

    # Install i3-gaps for Debian
    if echo $(lsb_release -ds) | grep -q "Debian"; then
        curl -s https://api.github.com/repos/barnumbirr/i3-gaps-debian/releases/latest \
            | grep "browser_download_url" \
            | grep "buster.deb\"" \
            | awk '{print $2}' \
            | tr -d \" \
            | xargs wget -O "/tmp/i3gaps.deb" \
        && sudo apt install -y "/tmp/i3gaps.deb"
    fi

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

install_dmenu () {
    sudo git clone https://git.suckless.org/dmenu /opt/dmenu && \
        cd /opt/dmenu
        sudo git apply $dir/dmenu/dmenu-config.diff
        sudo make && sudo make install
}

install_gtk () {
    git clone https://github.com/sainnhe/gruvbox-material-gtk.git /tmp/gruvbox-material-gtk && \
        sudo mv /tmp/gruvbox-material-gtk/themes/Gruvbox-Material-Dark /usr/share/themes
        sudo mv /tmp/gruvbox-material-gtk/icons/Gruvbox-Material-Dark /usr/share/icons
}

install_zsh () {
    sudo apt install zsh
    ZSH="${XDG_DATA_HOME:-$HOME/.local/share}/oh-my-zsh" ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh" sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    # Remove default oh-my-zsh's zshrc file.
    rm -rf ~/.zshrc
}


#######################################################################################


read -rp "Make preinstallation? [y/n]: " preinstallation

if [ "$preinstallation" = "y" ]; then
    install_X11
    install_dmenu
    install_evince
    install_git
    install_gtk
    install_i3
    install_mpv
    install_nerdfont
    install_oh-my-zsh
    install_pynvim
    install_zsh
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
