{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
with lib.custom;
let
  cfg = config.services.jellyfin-custom;
in
{
  options.services.jellyfin-custom = with types; {
    enable = mkBoolOpt true "Enable/disable Jellyfin server";
  };
  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.jellyfin
      pkgs.jellyfin-web
      pkgs.jellyfin-ffmpeg
    ];
    services.jellyfin = {
      enable = true;
      openFirewall = true;
      user = config.user.name;
    };
  };
}
