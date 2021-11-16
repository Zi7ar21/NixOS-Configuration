{ config, pkgs, nur, ... }:
{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "nemesis";
  home.homeDirectory = "/home/nemesis";

  home.packages = with pkgs; [
    git
    htop
    fortune
    cowsay
    vscodium
    neofetch
    aria2
    xdg-desktop-portal-wlr
    mpv
    lm_sensors
    qemu
    OVMF
    xdg-utils
    gnupg
    bash
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
  ];

  home.file.".icons/default".source = "${pkgs.vanilla-dmz}/share/icons/Vanilla-DMZ";

  xdg.mime.enable = true;

  programs.bash = {
    enable = true;
    shellAliases = {
      weather = "curl https://wttr.in/?0";
      get = "curl -LO";
      sudo = "doas";
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
  # optional for nix flakes support
  programs.direnv.nix-direnv.enableFlakes = true;

  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "gnome3";
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.05";
}