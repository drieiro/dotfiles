# zsh configuration

# tmux settings
# ZSH_TMUX_AUTOSTART=true                 # Automatically starts tmux
# ZSH_TMUX_AUTOCONNECT=false              # Use terminal's tabs too

# History settings
setopt share_history
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

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.config/zsh/oh-my-zsh"

# Set name of the theme to load
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="drieiro"

# stamp shown in the history command output.
HIST_STAMPS="%d-%m-%y %T"

# Plugins ('~/.oh-my-zsh/plugins/*' and '~/.oh-my-zsh/custom/plugins')
[ -d $ZSH/custom/plugins/zsh-syntax-highlighting ] || git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH/custom/plugins/zsh-syntax-highlighting
plugins=(git sudo zsh-syntax-highlighting vi-mode)

# pfetch variables
export PF_INFO="ascii title os kernel wm pkgs shell editor"

# Oh my zsh
source $ZSH/oh-my-zsh.sh

# fzf
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh ] && source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh
