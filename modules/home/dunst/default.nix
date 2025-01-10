{ config, lib, ... }:
with lib;
with lib.custom;
let
  cfg = config.dunst;
in
{
  options.dunst = with types; {
    enable = mkBoolOpt true "Enable or disable waybar";
  };

  config = mkIf cfg.enable {
    services.dunst = {
      enable = true;
      settings = {
        global = {
          frame_color = "#89b4fa";
          separator_color = "frame";
          highlight = "#89b4fa";
        };
        urgency_low = {
          background = "#1e1e2e";
          foreground = "#cdd6f4";
        };
        urgency_normal = {
          background = "#1e1e2e";
          foreground = "#cdd6f4";
        };
        urgency_critical = {
          background = "#1e1e2e";
          foreground = "#cdd6f4";
          frame_color = "#fab387";
        };
      };
    };
  };
}
