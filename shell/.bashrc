#
# ~/.bashrc
#

# If not running interactively, don't do anything
#[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

# Add aliases
source $HOME/.config/shell/aliasrc
# Add functions
source $HOME/.config/shell/functionrc

HISTSIZE=1000
HISTFILESIZE=4000
export HISTFILE=$HOME/.cache/history

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# set PATH so it includes my personal scripts if the folder exists (it should)
if [ -d "$HOME/.local/scripts" ] ; then
    PATH="$HOME/.local/scripts:$PATH"
    export SC=$HOME/.local/scripts
fi

# set PATH so it includes specific i3 scripts
if [ -d "$HOME/.config/i3/scripts" ] ; then
    PATH="$HOME/.config/i3/scripts:$PATH"
fi

export QT_AUTO_SCREEN_SCALE_FACTOR=0
export QT_QPA_PLATFORMTHEME=qt5ct
export QT_IM_MODULE=xim
export BATS_RUN_SKIPPED="true"
#alias spotify="spotify --no-zygote"
# pfetch variables
export PF_INFO="ascii title os kernel wm pkgs shell editor"

# Default software
export EDITOR="nvim"
export BROWSER="firefox"
export TERMINAL="gnome-terminal"

# Clean up
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
export GNUPGHOME=${XDG_CONFIG_HOME:-$HOME/.config}/gnupg
export LESSHISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/less/lesshst"
export GTK2_RC_FILES="${XDG_CONFIG_HOME:-$HOME/.config}/gtk-2.0/gtkrc-2.0"
export PYLINTHOME="${XDG_DATA_HOME:-$HOME/.local/share}/pylint"
export ICEAUTHORITY=${XDG_CACHE_HOME:-$HOME/.cache}/ICEauthority
export WGETRC="${XDG_CONFIG_HOME:-$HOME/.config}/wget/wgetrc"
export USERXSESSION="$XDG_CACHE_HOME/X11/xsession"
export USERXSESSIONRC="$XDG_CACHE_HOME/X11/xsessionrc"
export ALTUSERXSESSION="$XDG_CACHE_HOME/X11/Xsession"
export ERRFILE="$XDG_CACHE_HOME/X11/xsession-errors"

# ytfzf
export YTFZF_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/ytfzf"
export YTFZF_CONFIG_FILE="$YTFZF_CONFIG_DIR/conf.sh"

# fzf
[ -f /usr/share/fzf/key-bindings.bash ] && source /usr/share/fzf/key-bindings.bash
[ -f /usr/share/fzf/completion.bash ] && source /usr/share/fzf/completion.bash

eval "$(starship init bash)"
