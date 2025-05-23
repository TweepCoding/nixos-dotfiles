{ config, lib, ... }:
with lib;
with lib.custom;
let
  cfg = config.desktop.hypr.hypridle;
in
{
  options.desktop.hypr.hypridle = with types; {
    enable = mkBoolOpt true "Enables hypridle";
  };
  config = mkIf cfg.enable {
    home-manager.users.${config.user.name} = {
      services.hypridle = {
        enable = true;
        settings = {
          general = {
            lock_cmd = "pidof hyprlock || hyprlock";
            before_sleep_cmd = "loginctl lock-session";
            after_sleep_cmd = "hyprctl dispatch dpms on";
          };
          listener = [
            {
              timeout = 150;
              on-timeout = "brightnessctl -s set 10";
              on-resume = "brightnessctl -r";
            }
            {
              timeout = 450;
              on-timeout = "hyprctl dispatch dpms off";
              on-resume = "hyprctl dispatch dpms on";
            }
            {
              timeout = 900;
              on-timeout = "loginctl lock-session";
            }
          ];
        };
      };
    };
  };
}
