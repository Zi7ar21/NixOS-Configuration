{ config, lib, pkgs, ... }:
{
wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;

    config = {
      bars = [];
      modifier = "Mod4";
      input = {
        "*" = {
          xkb_layout = "us,iq";
          xkb_options = "grp:rctrl_toggle";
        };
      };
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

        "Print" = "exec grim -g \"$(slurp -d)\" - | wl-copy";
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
}