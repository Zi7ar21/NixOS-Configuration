{ config, lib, pkgs, ... }:
{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    git
    htop
    fortune
    cowsay
    vscodium
    neofetch
    aria2

    source-code-pro
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    roboto

    xdg-desktop-portal-wlr
    mpv
    lm_sensors
    qemu
    OVMF
    xdg-utils
    gnupg
    cava
    element-desktop
    gsettings-desktop-schemas
    kdenlive
    gtk-engine-murrine
    ungoogled-chromium
    papirus-icon-theme
    pinentry
    arc-theme
    pinentry-curses
    gnome3.dconf
    jq
    yt-dlp
    podman
    podman-compose
    pandoc
    wl-clipboard
    alacritty
    slurp
    grim
    libressl
    ffmpeg-full
    bc
  ];

  home.file.".icons/default".source = "${pkgs.vanilla-dmz}/share/icons/Vanilla-DMZ";
  fonts.fontconfig.enable = true;
  xdg.mime.enable = true;

  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "curses";
    enableSshSupport = true;
    sshKeys = [ "3141387B309EBA5CD4C508AB40E30F8760283127" ];
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      weather = "curl https://wttr.in/?0";
      get = "curl -LO";
      sudo = "doas";
      ytAudio = "yt-dlp -f bestaudio -o '%(title)s.%(ext)s' -x --audio-format best";
      docker-compose = "podman-compose";
      gpg2-verify = "gpg2 --no-default-keyring --keyring verichain.gpg";
    };

    initExtra = ''
        PS1="\[\033[38;5;2m\]\u\[$(tput sgr0)\] \w \[$(tput bold)\]\\$\[$(tput sgr0)\] \[$(tput sgr0)\]"
        TERM=xterm
        neofetch -l
        date && echo
        export PATH=$PATH:$HOME"/Documents/Scripts/"
    '';
  };

  gtk = {
    theme.name = "Arc Dark";
  };
  
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;
}
