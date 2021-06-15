# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

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
    SC=$HOME/.local/scripts
fi

# set PATH so it includes specific i3 scripts
if [ -d "$HOME/.config/i3/scripts" ] ; then
    PATH="$HOME/.config/i3/scripts:$PATH"
fi

export QT_AUTO_SCREEN_SCALE_FACTOR=0
export spotify="spotify --no-zygote"
alias gnome-control-center="env XDG_CURRENT_DESKTOP=GNOME gnome-control-center"

if test -z "$DBUS_SESSION_BUS_ADDRESS"; then
    eval $(dbus-launch --sh-syntax --exit-with-session)
fi
if [ -n "$DESKTOP_SESSION" ];then
    eval $(gnome-keyring-daemon --start)
    export SSH_AUTH_SOCK
fi
