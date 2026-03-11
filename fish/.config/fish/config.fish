# ----- Starship -----
starship init fish | source

# ----- Theme -----
set -g fish_color_command cyan
set -g fish_color_param white
set -g fish_color_error red
set -g fish_color_autosuggestion brblack
set -g fish_color_quote yellow
set -g fish_color_operator green
set -g fish_color_end magenta

# ----- Better tools -----
alias ls="eza --icons --group-directories-first"
alias ll="eza -lah --icons --git"
alias cat="bat"
alias find="fd"

# ----- Git shortcuts -----
alias g="git"
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gp="git push"
alias gl="git pull"

# ----- Kubernetes -----
alias k="kubectl"
alias kgp="kubectl get pods"
alias kgs="kubectl get svc"
alias kctx="kubectl config use-context"
alias kns="kubectl config set-context --current --namespace"

# ----- zoxide -----
zoxide init fish | source
alias cd="z"

# ----- fzf -----
set -gx FZF_DEFAULT_OPTS "
--height 40%
--layout=reverse
--border
--preview 'bat --style=numbers --color=always {}'
"

# Ctrl-R history search
function fish_user_key_bindings
    bind \cr 'history | fzf | read -l cmd; commandline $cmd'
end


function use_podman
    if test "$argv[1]" = "on"
        # Enable Podman as Docker
        mkdir -p ~/bin/docker-wrapper
        echo '#!/usr/bin/env fish' > ~/bin/docker-wrapper/docker
        echo 'exec podman $argv' >> ~/bin/docker-wrapper/docker
        chmod +x ~/bin/docker-wrapper/docker


        echo "Docker commands will now use Podman."
    else if test "$argv[1]" = "off"
        # Disable Podman wrapper
        if test -f ~/bin/docker-wrapper/docker
            rm ~/bin/docker-wrapper/docker
        end
        
        echo "Docker commands restored to normal."
    else
        echo "Usage: use_podman on|off"
    end
end


# ----- PATH -----
set -gx PATH $HOME/.local/bin $PATH
set -gx PATH $HOME/.cargo/bin $PATH
set -gx PATH $HOME/go/bin $PATH
set -gx PATH $HOME/bin/docker-wrapper $PATH 

if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Amp CLI
export PATH="/home/aabid/.amp/bin:$PATH"

# opencode
fish_add_path /home/aabid/.opencode/bin
