{
  lib,
  userSettings,
  systemSettings,
  ...
}:
{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {

      monitor =
        [
          ",preferred,auto,1"
        ]
        ++ (
          if systemSettings.hostname == "stark" then
            [
              "eDP-1,highres,auto,1,bitdepth,8"
              "HDMI-A-1,highres,auto,1,bitdepth,8,mirror,eDP-1"
            ]
          else if systemSettings.hostname == "eisen" then
            [
              "HDMI-A-1,highres,auto,1,bitdepth,8"
            ]
          else
            [ ]
        );

      "$terminal" = userSettings.term;
      "$fileManager" = userSettings.fileManager;
      "$menu" = "sh $HOME/.config/rofi/bin/{launcher,runner,powermenu,screenshot}";
      "$powermenu" = "wlogout -p layer-shell";
      "$discord" = "vesktop";
      "$mainMod" = "SUPER";

      env = [
        "HYPRCURSOR_SIZE,24"
        "HYPRCURSOR_THEME,catppuccin-mocha-dark-cursors"
        "QT_QPA_PLATFORMTHEME,qt5ct"
        "GTK_BACKEND,wayland,x11,*"
        "QT_QPA_PLATFORM,wayland;xcb"
        "SDL_VIDEODRIVER,wayland"
        "CLUTTER_BACKEND,wayland"
      ];

      input = {
        kb_layout = "us";
        repeat_rate = 30;
        repeat_delay = 300;

        follow_mouse = 1;
        sensitivity = (if systemSettings.hostname == "stark" then 1 else 0.5);

        touchpad = {
          disable_while_typing = false;
          natural_scroll = true;
          scroll_factor = 0.1;
        };
      };

      device = lib.optional (systemSettings.hostname == "stark") {
        name = "synps/2-synaptics-touchpad";
        enabled = false;
      };

      general = {
        gaps_in = 4;
        gaps_out = 8;
        border_size = 0;

        layout = "master";
        allow_tearing = false;
      };

      decoration = {
        blur = {
          enabled = true;
          size = 2;
          passes = 2;
        };
        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };
        dim_inactive = true;
        dim_strength = 0.05;
        rounding = 8;
        blurls = "wofi";
      };

      animations = {
        enabled = true;
        bezier = "overshot, 0.13, 0.99, 0.29, 1.1";
        animation = [
          "windows, 1, 4, overshot, slide"
          "border, 1, 10, default"
          "fade, 1, 10, default"
          "workspaces, 1, 5, overshot, slide"
        ];
      };

      master = {
        new_status = "slave";
        mfact = 0.5;
      };

      gestures.workspace_swipe = "off";

      custom.rules.windowrulev2 = [
        "opacity 0.0 override 0.0 override,class:^(xwaylandvideobridge)$"
        "noanim,class:^(xwaylandvideobridge)$"
        "noinitialfocus,class:^(xwaylandvideobridge)$"
        "maxsize 1 1,class:^(xwaylandvideobridge)$"
        "noblur,class:^(xwaylandvideobridge)$"
        "animation slide, class:^(wofi)$"
      ];

      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
      };

      bind = [
        "$mainMod, RETURN, exec, $terminal"
        "$mainMod, Q, killactive, "
        "$mainMod, E, exec, $fileManager"
        "$mainMod, F, togglefloating, "
        "$mainMod, W, exec, $menu"
        "$mainMod, h, movefocus, l"
        "$mainMod, l, movefocus, r"
        "$mainMod, k, movefocus, u"
        "$mainMod, j, movefocus, d"
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"
        "$mainMod SHIFT, c, layoutmsg, swapwithmaster auto"
        "$mainMod, S, exec, grimblast copysave area"
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
        "$mainMod, F1, exec, pamixer -t"
        "$mainMod, F2, exec, pamixer -d 5"
        "$mainMod, F3, exec, pamixer -i 5"
        "$mainMod, L, exec, hyprlock"
        "$mainMod, escape, exec, $powermenu"
        "$mainMod, M, exec, $mail"
        "$mainMod, N, exec, $notion"
        "$mainMod, D, exec, $discord"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      exec-once = [
        "hyprlock"
        "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
      ];
    };
  };
}
