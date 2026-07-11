{ pkgs, ... }:

{
  wayland.windowManager.mango = {
    enable = true;

    settings = {
      # DMS source includes
      source = [
        "~/.config/mango/dms/colors.conf"
        "~/.config/mango/dms/layout.conf"
        "~/.config/mango/dms/outputs.conf"
      ];

      # DMS autostart
      "exec-once" = [
        "dms run"
        "wl-paste --type text --watch cliphist store"
        "dbus-update-activation-environment --systemd --all"
        "systemctl --user start mango-session.target"
      ];

      # Environment variables
      env = [
        "QT_QPA_PLATFORM,wayland"
        "ELECTRON_OZONE_PLATFORM_HINT,auto"
        "QT_QPA_PLATFORMTHEME,gtk3"
      ];

      # Keyboard layouts
      xkb_rules_layout = "us,br";
      xkb_rules_variant = ",";

      # DMS appearance
      border_radius = 12;
      borderpx = 2;
      focused_opacity = 1.0;
      unfocused_opacity = 0.9;

      # Gaps
      gappih = 5;
      gappiv = 5;
      gappoh = 5;
      gappov = 5;

      # Animations
      animations = 1;
      layer_animations = 1;
      animation_type_open = "slide";
      animation_type_close = "slide";
      animation_fade_in = 1;
      animation_fade_out = 1;
      animation_duration_move = 500;
      animation_duration_open = 400;
      animation_duration_tag = 350;
      animation_duration_close = 800;
      animation_curve_open = "0.46,1.0,0.29,1";
      animation_curve_move = "0.46,1.0,0.29,1";
      animation_curve_tag = "0.46,1.0,0.29,1";
      animation_curve_close = "0.08,0.92,0,1";

      # DMS layer rules
      layerrule = [
        "noanim:1,layer_name:^dms"
      ];

      # DMS window rules
      windowrule = [
        "isnoborder:1,appid:^org\\.gnome\\.#"
        "isnoborder:1,appid:^org\\.wezfurlong\\.wezterm$"
        "isnoborder:1,appid:^Alacritty$"
        "isnoborder:1,appid:^com\\.mitchellh\\.ghostty$"
        "isnoborder:1,appid:^kitty$"
        "isfloating:1,appid:^org\\.quickshell$"
        "isfloating:1,appid:^MangoHelp$"
      ];

      # Layouts
      tagrule = [
        "id:1,layout_name:tile"
        "id:2,layout_name:tile"
        "id:3,layout_name:tile"
        "id:4,layout_name:tile"
        "id:5,layout_name:tile"
        "id:6,layout_name:tile"
        "id:7,layout_name:tile"
        "id:8,layout_name:tile"
        "id:9,layout_name:tile"
      ];

        # DMS keybindings
        bind = [
          # Reload config
          "SUPER,r,reload_config"

          # DMS launchers
          "SUPER,space,spawn,dms ipc call spotlight toggle"
          "SUPER+SHIFT,space,switch_keyboard_layout"
        "SUPER,v,spawn,dms ipc call clipboard toggle"
        "SUPER,m,spawn,dms ipc call processlist focusOrToggle"
        "SUPER,comma,spawn,dms ipc call settings focusOrToggle"
        "SUPER,n,spawn,dms ipc call notifications toggle"
        "SUPER,y,spawn,dms ipc call dankdash wallpaper"

        # Security
        "SUPER+ALT,l,spawn,dms ipc call lock lock"

        # Terminal
        "Alt,Return,spawn,alacritty"

        # Keybinds help
        "SUPER,F1,spawn,alacritty --class MangoHelp -e ~/.config/mango/show-keybinds.sh"

        # Kill client
        "ALT,q,killclient"

        # Switch window focus
        "SUPER,Tab,focusstack,next"
        "ALT,Left,focusdir,left"
        "ALT,Right,focusdir,right"
        "ALT,Up,focusdir,up"
        "ALT,Down,focusdir,down"

        # Swap window
        "SUPER+SHIFT,Up,exchange_client,up"
        "SUPER+SHIFT,Down,exchange_client,down"
        "SUPER+SHIFT,Left,exchange_client,left"
        "SUPER+SHIFT,Right,exchange_client,right"

        # Window status
        "SUPER,g,toggleglobal"
        "ALT,Tab,togglejump"
        "ALT,backslash,togglefloating"
        "ALT,a,togglemaximizescreen"
        "ALT,f,togglefullscreen"
        "ALT+SHIFT,f,togglefakefullscreen"
        "SUPER,i,minimized"
        "SUPER,o,toggleoverlay"
        "SUPER+SHIFT,I,restore_minimized"
        "ALT,z,toggle_scratchpad"

        # Layout
        "SUPER+SHIFT,n,switch_layout"

        # Tag switch
        "SUPER,Left,viewtoleft,0"
        "CTRL,Left,viewtoleft_have_client,0"
        "SUPER,Right,viewtoright,0"
        "CTRL,Right,viewtoright_have_client,0"
        "CTRL+SUPER,Left,tagtoleft,0"
        "CTRL+SUPER,Right,tagtoright,0"

        "Ctrl,1,view,1,0"
        "Ctrl,2,view,2,0"
        "Ctrl,3,view,3,0"
        "Ctrl,4,view,4,0"
        "Ctrl,5,view,5,0"
        "Ctrl,6,view,6,0"
        "Ctrl,7,view,7,0"
        "Ctrl,8,view,8,0"
        "Ctrl,9,view,9,0"

        "Alt,1,tag,1,0"
        "Alt,2,tag,2,0"
        "Alt,3,tag,3,0"
        "Alt,4,tag,4,0"
        "Alt,5,tag,5,0"
        "Alt,6,tag,6,0"
        "Alt,7,tag,7,0"
        "Alt,8,tag,8,0"
        "Alt,9,tag,9,0"

        # Monitor switch
        "alt+shift,Left,focusmon,left"
        "alt+shift,Right,focusmon,right"
        "SUPER+Alt,Left,tagmon,left"
        "SUPER+Alt,Right,tagmon,right"

        # Gaps
        "ALT+SHIFT,X,incgaps,1"
        "ALT+SHIFT,Z,incgaps,-1"
        "ALT+SHIFT,R,togglegaps"

        # Move window
        "CTRL+SHIFT,Up,movewin,+0,-50"
        "CTRL+SHIFT,Down,movewin,+0,+50"
        "CTRL+SHIFT,Left,movewin,-50,+0"
        "CTRL+SHIFT,Right,movewin,+50,+0"

        # Resize window
        "CTRL+ALT,Up,resizewin,+0,-50"
        "CTRL+ALT,Down,resizewin,+0,+50"
        "CTRL+ALT,Left,resizewin,-50,+0"
        "CTRL+ALT,Right,resizewin,+50,+0"

        # DMS audio controls
        "NONE,XF86AudioRaiseVolume,spawn,dms ipc call audio increment 3"
        "NONE,XF86AudioLowerVolume,spawn,dms ipc call audio decrement 3"
        "NONE,XF86AudioMute,spawn,dms ipc call audio mute"

        # DMS brightness controls
        "NONE,XF86MonBrightnessUp,spawn,dms ipc call brightness increment 5"
        "NONE,XF86MonBrightnessDown,spawn,dms ipc call brightness decrement 5"
      ];

      # Mouse bindings
      mousebind = [
        "SUPER,btn_left,moveresize,curmove"
        "SUPER,btn_middle,togglemaximizescreen,0"
        "SUPER,btn_right,moveresize,curresize"
      ];

      # Axis bindings
      axisbind = [
        "SUPER,UP,viewtoleft_have_client"
        "SUPER,DOWN,viewtoright_have_client"
      ];
    };
  };

  xdg.configFile."mango/dms/colors.conf".text = "";
  xdg.configFile."mango/dms/layout.conf".text = "";
  xdg.configFile."mango/dms/outputs.conf".text = "";
  xdg.configFile."mango/show-keybinds.sh" = {
    source = ./show-keybinds.sh;
    executable = true;
  };
}
