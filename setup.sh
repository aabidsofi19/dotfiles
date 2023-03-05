export PATH=$HOME/squashfs-root/usr/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH

#Install Other Packages
sudo apt-get install neofetch ripgrep  wget tmux exa

# Install Rust ToolChain
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Install StarshipPrompt
curl -sS https://starship.rs/install.sh | sh

# Install NvChad
git clone https://github.com/NvChad/NvChad ./dots/config/nvim --depth 1 
# Install Some Packages 
python install_packages.py

#sync dotfiles 
cp -r ./dots/*  $HOME/ 

