export PATH=$HOME/squashfs-root/usr/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH

python install_packages.py


#sync dotfiles 

cp -r ./zsh/. $HOME/

. ./zsh/.profile

