{ config, lib, ... }:
with lib;
with lib.custom;
let
  cfg = config.desktop.hypr.hyprlock;
in
{
  options.desktop.hypr.hyprlock = with types; {
    enable = mkBoolOpt true "Enables/disables hyprlock";
  };
  config = mkIf cfg.enable {
    programs.hyprlock = {
      enable = true;
      settings = {
        background = {
          path = ../../../../../images/background.png;
          blur_passes = 2;
          contrast = 0.8916;
          brightness = 0.8172;
          vibrancy = 0.1696;
          vibrancy_darkness = 0.0;
        };
        general = {
          no_fade_in = false;
          grace = 0;
          disable_loading_bar = false;
        };
        label = [
          {
            text = "cmd[update:1000] echo -e \"$(date +\"%A\")\"";
            color = "rgba(216, 222, 233, 0.70)";
            font_size = 90;
            font_family = "SF Pro Display Bold";
            position = "0, 350";
            halign = "center";
            valign = "center";
          }
          {
            text = "cmd[update:1000] echo -e \"$(date +\"%d %B\")\"";
            color = "rgba(216, 222, 233, 0.70)";
            font_size = 40;
            font_family = "SF Pro Display Bold";
            position = "0, 250";
            halign = "center";
            valign = "center";
          }
          {
            text = "cmd[update:1000] echo \"<span>$(date +\"- %I:%M -\")</span>\"";
            color = "rgba(216, 222, 233, 0.70)";
            font_size = 20;
            font_family = "SF Pro Display Bold";
            position = "0, 190";
            halign = "center";
            valign = "center";
          }
          {
            text = "    $USER";
            color = "rgba(216, 222, 233, 0.80)";
            outline_thickness = 2;
            dots_size = 0.2;
            dots_spacing = 0.2;
            dots_center = "true";
            font_size = 18;
            font_family = "SF Pro Display Bold";
            position = "0, -130";
            halign = "center";
            valign = "center";
          }
          {
            text = "󰐥  󰜉  󰤄";
            color = "rgba(255, 255, 255, 0.6)";
            font_size = 50;
            position = "0, 100";
            halign = "center";
            valign = "bottom";
          }
        ];
        image = {
          path = ../../../../../images/pfp.png;
          border_size = 2;
          border_color = "rgba(30, 5, 50, .65)";
          size = 130;
          rounding = -1;
          rotate = 0;
          reload_time = -1;
          position = "0, 40";
          halign = "center";
          valign = "center";
        };
        shape = {
          size = "300, 60";
          color = "rgba(255, 255, 255, .1)";
          rounding = -1;
          border_size = 0;
          border_color = "rgba(255, 255, 255, 0)";
          rotate = 0;
          xray = false;
          position = "0, -130";
          halign = "center";
          valign = "center";
        };
        input-field = {
          size = "300, 60";
          outline_thickness = 2;
          dots_size = 0.2;
          dots_spacing = 0.2;
          dots_center = true;
          outer_color = "rgba(255, 255, 255, 0)";
          inner_color = "rgba(255, 255, 255, 0.1)";
          font_color = "rgb(200, 200, 200)";
          fade_on_empty = false;
          font_family = "SF Pro Display Bold";
          placeholder_text = "<i><span foreground=\"##ffffff99\">🔒 Enter Pass</span></i>";
          hide_input = false;
          position = "0, -210";
          halign = "center";
          valign = "center";
        };
      };
    };
  };
}
