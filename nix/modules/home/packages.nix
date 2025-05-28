{ inputs, pkgs, ... }:
# let
  # _2048 = pkgs.callPackage ../../pkgs/2048/default.nix {};
# in
{
  home.packages = with pkgs; [
    # Development Tools
    gcc                   # GNU Compiler Collection
    gnumake               # GNU Make build tool
    # jdk17                 # Java Development Kit 17
    python3Full               # Python programming language
    nodejs                # JavaScript runtime
    rustup                # Rust toolchain installer
    go_1_24               # Go programming language
    golangci-lint         # fast lint runner for go
    gopls                 # go language server
    vscode-fhs            # Visual Studio Code (FHS version)
    zed-editor            # Zed code editor
    nil                   # Nix language server
    nodePackages.typescript-language-server # TypeScript language server
    nodePackages.npm      # Node Package Manager
    nodePackages.pnpm     # Fast, disk space efficient package manager
    nodePackages.eslint_d # JavaScript linter
    python312Packages.pyyaml
    open-policy-agent
    kind
    kubectl

    gh                    # GitHub CLI
    lazygit               # Terminal UI for git commands
    gitui                 # Terminal UI for git
    helix                 # helix text editor
    zig                   # zig language and toolchain
    zls                   # zig language server and lsp support
    pgadmin4             # PostgreSQL administration tool
    jetbrains.datagrip
    jetbrains.webstorm
    # tailscale             # Tailscale VPN client
    ngrok
    # gitbutler            # Git client for simultaneous branches on top of your existing workflow


    # System Utilities
    btop                  # Resource monitor
    iotop                 # I/O monitor
    iftop                 # Network monitor
    ncdu                  # Disk usage analyzer
    strace                # System call tracer
    ltrace                # Library call tracer
    sysstat               # System performance tools
    lm_sensors            # Hardware monitoring
    ethtool               # Network driver debugging
    pciutils              # PCI utilities
    usbutils              # USB utilities
    poweralertd           # Power management daemon
    gparted               # Partition editor
    bleachbit             # System cleaner
    blueman               # Blutooh mananger
    udiskie               # Auto mount usb devices
    mission-center        # gtk4 systemmonitor app


    # File Management
    nautilus              # GNOME file manager
    spacedrive            # Open source file manager, powered by a virtual distributed filesystem
    dolphin               # KDE file manager
    ranger                # Terminal file manager
    yazi                  # Another terminal file manager
    fd                    # Alternative to 'find'
    eza                   # Modern replacement for 'ls'
    fzf                   # Fuzzy finder
    ripgrep               # Fast grep alternative
    tree                  # Directory listing
    file                  # File type identifier
    xdg-utils             # Desktop integration utilities

    # Text Processing and Viewing
    gtt                   # Google Translate TUI
    evince                # GNOME document viewer
    zathura               # Minimalistic document viewer
    tdf                   # CLI PDF viewer
    glow                  # Markdown viewer
    memos                 # A lightweight, self-hosted memo hub

    # Multimedia
    mpv                   # Video player
    ffmpeg                # Multimedia framework
    # audacity              # Audio editor
    # gimp                  # Image editor
    imv                   # Image viewer
    simplescreenrecorder  # Screen recording software
    playerctl             # Media player controller
    soundwireserver       # Audio streaming to Android
    noisetorch            # Noise suppression for microphone
    easyeffects           # Audio effects for PulseAudio

    # Productivity
    # libreoffice           # Office suite
    qalculate-gtk         # Advanced calculator
    todo                  # CLI todo list
    slack                 # Team communication
    zoom-us               # Video conferencing
    clickup               # Project management
    jekyll                # Static site generator
    hugo                  # Another static site generator


    #Browsing
    firefox
    google-chrome         # Web browser

    # Network Tools
    wget                  # File downloader
    aria2                 # Download utility
    yt-dlp-light          # YouTube downloader
    # cloudflare-warp       # Cloudflare VPN client
    mtr                   # Network diagnostic tool
    iperf3                # Network performance tool
    dnsutils              # DNS utilities
    ldns                  # DNS programming library and tools
    socat                 # Multipurpose relay
    nmap                  # Network scanner
    ipcalc                # IP address calculator

    # System Customization and Appearance
    nitch                 # System information tool
    neofetch              # System information tool with ASCII art
    cmatrix               # Matrix-like screen saver
    cbonsai               # Bonsai tree generator
    pipes                 # Animated pipes screen saver

    # Development Utilities
    entr                  # File watcher and command runner
    nix-prefetch-github   # Prefetch GitHub repositories
    valgrind              # Memory debugging tool
    openssl               # Cryptography and SSL/TLS toolkit

    # Text and Hex Editors
    bitwise               # Base conversion and bitwise operation
    hexdump               # Hexadecimal view of data
    xxd                   # Hexdump creator

    # Archive Management
    zip                   # Zip compression utility
    unzip                 # Zip extraction utility
    xz                    # XZ compression utility
    p7zip                 # 7-Zip file archiver
    gnutar                # GNU tar archiving utility
    zstd                  # Zstandard compression

    # Shell and Command Line Utilities
    gawk                  # GNU awk
    gnused                # GNU stream editor
    wl-clipboard          # Wayland clipboard utilities
    cliphist              # Clipboard manager
    gnupg                 # GNU Privacy Guard
    killall               # Process termination utility
    cowsay                # Generate ASCII art cows
    toipe                 # Typing test in terminal

    # Audio Control
    pamixer               # PulseAudio mixer
    pavucontrol           # PulseAudio volume control GUI

    # Gaming
    # prismlauncher         # Minecraft launcher
    # winetricks            # Wine helper scripts
    # wineWowPackages.wayland # Wine for Wayland

    # Graphics and Image Processing
    gifsicle              # GIF manipulation tool

    # Package Management
    nix-output-monitor    # Nix build output monitor
    bundler               # Ruby dependency manager

    # Miscellaneous
    zenity                # Display GTK+ dialogs
    libnotify             # Desktop notifications library
    gtrash                # Trash management utility
    man-pages             # Extra man pages
    motrix                # Download manager
    appimage-run          # run appimages


    minikube
    transmission_4-gtk

    # Custom Packages
    inputs.alejandra.defaultPackage.${system} # Nix code formatter
    # inputs.zen-browser.packages."${system}".specific

    ## Gaming
    rpcs3
    ryujinx
    cemu
    # retroarch
# retroarchFull
  ];
}
