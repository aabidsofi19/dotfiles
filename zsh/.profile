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

alias vi=lvim
alias tmx="tmux -u"
#sh ~/unix_scripts/battery_notifier.sh &

export ANDROID=$HOME/Android
export PATH=$ANDROID/tools:$PATH
export PATH=$ANDROID/tools/bin:$PATH
export PATH=$ANDROID/platform-tools:$PATH# Android SDK
export ANDROID_SDK=$HOME/ANDROID
export PATH=$ANDROID_SDK:$PATH
export PATH=/snap/bin:$PATH
export PATH=$HOME/go/bin:$PATH
export PATH=$HOME/mongodb/bin:$PATH
export PATH="/home/aabid/solana-1.8.5"/bin:"$PATH"
export PATH=$HOME/.avm/bin:$PATH
export PATH=$HOME/squashfs-root/usr/bin:$PATH
. "$HOME/.cargo/env"

