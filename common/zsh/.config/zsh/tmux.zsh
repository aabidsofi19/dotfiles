# Automatically create a tmux session or use a already
# exiting one when creating a shell

if [[ $TERM = "xterm-256color"  ]]; then

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
