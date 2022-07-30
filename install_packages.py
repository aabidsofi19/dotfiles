from contextlib import suppress
from subprocess import PIPE
import subprocess as sp
import os

HOME = os.environ.get("HOME")

def is_installed(name: str):
    try:
        sp.run([name, "--version"], stdout=PIPE)
        print(f"{name} already available")
        return True
    except Exception as e:
        return False


def install_package(name: str) -> None:

    print("[+] installing ", name)
    sp.run(["sudo", "apt", "install", "-y", name], check=True)


def download_file(url, location):
    installer_output = sp.run(
        ["curl", url, "--output", location],
        check=True,
    )



def install_lunar_vim() -> None:

    """install lunar vim"""

    installer_url = "https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh"
    download_file(installer_url, "./lunar-installer.sh")
    sp.run(["bash", "./lunar-installer.sh", "-y"])


def install_oh_my_zsh() -> None:

    url = "https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh"
    sp.run(["wget", "-O", "oh-my-zsh-install.sh", url])
    sp.run(["sh", "./oh-my-zsh-install.sh","-y"])


def install_neovim_latest():

    print("Installing neovim")
    release_url = (
        "https://github.com/neovim/neovim/releases/latest/download/nvim.appimage"
    )
    sp.run(["curl", "-LO", release_url], check=True)
    sp.run(["chmod", "u+x", "nvim.appimage"], check=True)
    sp.run(["./nvim.appimage", "--appimage-extract"], check=True)
    
    try:
        # moves the squadh-root to home and
        sp.run(["mv", "./squashfs-root", f"{HOME}"], check=True)
    except Exception as e:
        print(e)
    
    sp.run([".",f"./zsh/.profile"],shell=True)
    
    print("Done")


def install_rust_toolchain():

    url = "https://sh.rustup.rs"
    download_file(url, "./rust-installer.sh")
    sp.run(["sh", "./rust-installer.sh", "-y"])
    sp.run([".",f"./zsh/.profile"],shell=True)

def install_packages(packages):
    to_be_installed = [p for p in packages if not is_installed(p)]
    for p in to_be_installed:

        with suppress():
            sp.run(["sudo", "apt-get", "install", p, "-y"])

def install_zsh_plugins() :
    home = os.environ.get("HOME")
    if not os.path.exists(home+"/.oh-my-zsh") :
        install_oh_my_zsh()
    sp.run(["sh","./install-zsh-plugins.sh"])


def install_common_deps():
    deps = ["neofetch", "ripgrep", "wget","tmux","exa"]
    install_packages(deps)

    if not is_installed("cargo"):
        install_rust_toolchain()

    if not is_installed("nvim"):
        with suppress():
            install_neovim_latest()

    if not is_installed("lvim"):
        with suppress():
            install_lunar_vim()
    
    with suppress() :
        install_oh_my_zsh()
    
    with suppress() :
        install_zsh_plugins()

if __name__ == "__main__":

    install_common_deps()
