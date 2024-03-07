## ░▀▀█░█▀▀░█░█░█▀▄░█▀▀
## ░▄▀░░▀▀█░█▀█░█▀▄░█░░
## ░▀▀▀░▀▀▀░▀░▀░▀░▀░▀▀▀
##
## rxyhn's Z-Shell configuration
## https://github.com/rxyhn

while read file
do 
  source "$ZDOTDIR/$file.zsh"
done <<-EOF
theme
env
aliases
utility
options
plugins
keybinds
prompt
conda
EOF



# Automatically create a tmux session or use a already
# exiting one when creating a shell

if [[ $TERM = "xterm-kitty" ]]; then

  session_name="sesh"

  # 1. First you check if a tmux session exists with a given name.
  tmux has-session -t=$session_name 2> /dev/null

  # 2. Create the session if it doesn't exists.
  if [[ $? -ne 0 ]]; then
    TMUX='' tmux new-session -d -s "$session_name"
  fi

  # 3. Attach if outside of tmux, switch if you're in tmux.
  if [[ -z "$TMUX" ]]; then
    tmux -u  attach -t "$session_name"
  else
    tmux -u switch-client -t "$session_name"
  fi

fi

# vim:ft=zsh:nowrap
#

function gi() { curl -sLw n https://www.toptal.com/developers/gitignore/api/$@ ;}



#nvm 
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm


#ocaml 
export OPAMROOT=$HOME/.opam/ 
[[ ! -r /home/aabid/.opam/opam-init/init.zsh ]] || source /home/aabid/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

#history 
HISTFILE=$HOME/.zsh_history
HISTSIZE=500000
SAVEHIST=500000
setopt appendhistory
setopt INC_APPEND_HISTORY  
setopt SHARE_HISTORY

#zoxide 
eval "$(zoxide init zsh --cmd cd)"
