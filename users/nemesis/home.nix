{ config, lib, pkgs, ... }:
{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "nemesis";
  home.homeDirectory = "/home/nemesis";

  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;

    config = {
      bars = [];
      modifier = "Mod4";
      window = {border = 3;};
      gaps = {
        inner = 5;
        outer = 5;
      };
      output = {
        "HDMI-A-2" = {
          pos = "1920 0";
        };
        "*" = {
          bg = "~/Pictures/wallpaper.jpg fill";
        };
      };

      keybindings = {
        "Mod4+Return" = "exec alacritty";
        "Mod4+Shift+q" = "kill";

        "Mod4+Left" = "focus left";
        "Mod4+down" = "focus down";
        "Mod4+Up" = "focus up";
        "Mod4+Right" = "focus right";

        "Mod4+Shift+Left" = "move left";
        "Mod4+Shift+down" = "move down";
        "Mod4+Shift+Up" = "move up";
        "Mod4+Shift+Right" = "move right";

        "Mod4+b" = "splith";
        "Mod4+v" = "splitv";
        "Mod4+f" = "fullscreen toggle";
        "Mod4+a" = "focus parent";

        "Mod4+s" = "layout stacking";
        "Mod4+w" = "layout tabbed";
        "Mod4+e" = "layout toggle split";

        "Mod4+space" = "floating toggle";

        "Mod4+1" = "workspace number 1";
        "Mod4+2" = "workspace number 2";
        "Mod4+3" = "workspace number 3";
        "Mod4+4" = "workspace number 4";
        "Mod4+5" = "workspace number 5";
        "Mod4+6" = "workspace number 6";
        "Mod4+7" = "workspace number 7";
        "Mod4+8" = "workspace number 8";
        "Mod4+9" = "workspace number 9";

        "Mod4+Shift+1" =
            "move container to workspace number 1";
        "Mod4+Shift+2" =
            "move container to workspace number 2";
        "Mod4+Shift+3" =
            "move container to workspace number 3";
        "Mod4+Shift+4" =
            "move container to workspace number 4";
        "Mod4+Shift+5" =
            "move container to workspace number 5";
        "Mod4+Shift+6" =
            "move container to workspace number 6";
        "Mod4+Shift+7" =
            "move container to workspace number 7";
        "Mod4+Shift+8" =
            "move container to workspace number 8";
        "Mod4+Shift+9" =
            "move container to workspace number 9";

        "Mod4+Shift+minus" = "move scratchpad";
        "Mod4+minus" = "scratchpad show";

        "Mod4+Shift+c" = "reload";
        "Mod4+Shift+e" =
            "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -b 'Yes, exit sway' 'swaymsg exit'";

        "Mod4+r" = "mode resize";
      };
    };
  };

  home.packages = with pkgs; [
    git
    htop
    fortune
    cowsay
    vscodium
    neofetch
    aria2
    source-code-pro
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
    unstable.podman
    unstable.podman-compose
    pandoc
    wl-clipboard
    alacritty
    slurp
    grim
  ];

  home.file.".icons/default".source = "${pkgs.vanilla-dmz}/share/icons/Vanilla-DMZ";

  xdg.mime.enable = true;

  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "tty";
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
