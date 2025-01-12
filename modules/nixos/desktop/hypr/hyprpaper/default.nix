{ config, lib, ... }:
with lib;
with lib.custom;
let
  cfg = config.desktop.hypr.hyprpaper;
in
{
  options.desktop.hypr.hyprpaper = with types; {
    enable = mkBoolOpt true "Enables/disables hyprpaper";
  };

  config = mkIf cfg.enable {
    home-manager.users.${config.user.name} = {
      services.hyprpaper = {
        enable = true;
        settings =
          let
            # TODO: Make this picture related directly to nix config
            backgroundPicture = "${../../../../../images/background.png}";
          in
          {
            preload = backgroundPicture;
            wallpaper = [
              "eDP-1,${backgroundPicture}"
              "HDMI-A-1,${backgroundPicture}"
              "Virtual-1,${backgroundPicture}"
            ];
          };
      };
    };
  };
}
