{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
with lib.custom;
let
  cfg = config.services.openrgb;
in
{
  options.services.openrgb = with types; {
    enable = mkBoolOpt true "Enable/disable OpenRGB";
  };
  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.openrgb
    ];
    services.hardware.openrgb = {
      enable = true;
      package = pkgs.openrgb-with-all-plugins;
      motherboard = "amd";
      server.port = 6742;
    };
    systemd.user.services.openrgb = {
      enable = true;
      description = "OpenRGB control";
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.openrgb} -c ffffff -m Direct";
      };
      wantedBy = [ "multi-user.target" ];
      after = [ "network.target" ];
    };
  };
}
