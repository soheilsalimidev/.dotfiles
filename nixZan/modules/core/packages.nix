{ pkgs, inputs, ... }: {
  programs = {
    firefox.enable = false; # Firefox is not installed by default
    hyprland.enable =
      true; # someone forgot to set this so desktop file is created
    dconf.enable = true;
    seahorse.enable = true;
    fuse.userAllowOther = true;
    mtr.enable = true;
    adb.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    nix-ld.enable = true;
    nix-ld.libraries = with pkgs; [ ];
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    acpi
    sshpass
    appimage-run # Needed For AppImage Support
    brightnessctl # For Screen Brightness Control
    cliphist # Clipboard manager using rofi menu
    cowsay # Great Fun Terminal Program
    docker-compose # Allows Controlling Docker From A Single File
    duf # Utility For Viewing Disk Usage In Terminal
    ffmpeg # Terminal Video / Audio Editing
    file-roller # Archive Manager
    gedit # Simple Graphical Text Editor
    gimp # Great Photo Editor
    glxinfo # needed for inxi diag util
    greetd.tuigreet # The Login Manager (Sometimes Referred To As Display Manager)
    htop # Simple Terminal Based System Monitor
    hyprpicker # Color Picker
    eog # For Image Viewing
    inxi # CLI System Information Tool
    killall # For Killing All Instances Of Programs
    libnotify # For Notifications
    lm_sensors # Used For Getting Hardware Temps
    lolcat # Add Colors To Your Terminal Command Output
    lshw # Detailed Hardware Information
    mpv # Incredible Video Player
    ncdu # Disk Usage Analyzer With Ncurses Interface
    onefetch # provides zsaneyos build info on current system
    pavucontrol # For Editing Audio Levels & Devices
    pciutils # Collection Of Tools For Inspecting PCI Devices
    pkg-config # Wrapper Script For Allowing Packages To Get Info On Others
    playerctl # Allows Changing Media Volume Through Scripts
    rhythmbox
    socat # Needed For Screenshots
    unrar # Tool For Handling .rar Files
    unzip # Tool For Handling .zip Files
    usbutils # Good Tools For USB Devices
    v4l-utils # Used For Things Like OBS Virtual Camera
    wget # Tool For Fetching Files With Links
    yazi # TUI File Manager
    inputs.zen-browser.packages."x86_64-linux".default
    audacity
    nodejs
    obs-studio
    handbrake
    yt-dlp
    zip
    vscode
    nwg-displays
    nwg-look
    gnumake
    pnpm
    alacritty
    stow
    tmux
    zoxide
    telegram-desktop
    v2raya
    ripgrep
    fd
    rustup
    lsd
    go
    lua-language-server
    gcc
    nwg-displays
    luarocks
    postgresql
    beekeeper-studio
    vscode.fhs
    openfortivpn
    nix-index
    fzf
    neovim
    ghostscript
    vlc
  ];
}
