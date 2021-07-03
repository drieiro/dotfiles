# zsh configuration

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.local/share/oh-my-zsh"

# Set name of the theme to load
ZSH_THEME="drieiro"

# Plugins ('~/.oh-my-zsh/plugins/*' and '~/.oh-my-zsh/custom/plugins')
[ -d $ZSH/custom/plugins/zsh-syntax-highlighting ] || git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH/custom/plugins/zsh-syntax-highlighting
plugins=(git sudo zsh-syntax-highlighting vi-mode)

# Oh my zsh
source $ZSH/oh-my-zsh.sh

# History settings
setopt share_history
HISTSIZE=10000000
SAVEHIST=10000000
HISTORY_IGNORE="(ls|exit|pwd|clear|history|cd)"
HISTFILE=$HOME/.cache/history
zshaddhistory() { whence ${${(z)1}[1]} >| /dev/null || return 1 } # Ignore failed commands

# Add aliases
source $HOME/.config/aliases
# Add functions
source $HOME/.config/functions
# Add rclone functions
source $HOME/.config/rclone_func

# Default software
export EDITOR="nvim"
export BROWSER="brave-browser"
export TERMINAL="alacritty"

# stamp shown in the history command output.
HIST_STAMPS="%d-%m-%y %T"

# pfetch variables
export PF_INFO="ascii title os kernel wm pkgs shell editor"

# fzf
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh ] && source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh
