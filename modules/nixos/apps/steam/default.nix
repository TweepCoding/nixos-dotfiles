{ lib, config, ... }:
with lib;
with lib.custom;
let
  cfg = config.apps.steam;
in
{
  options.apps.steam = with types; {
    enable = mkBoolOpt true "Enable/disable steam";
  };
  config = mkIf cfg.enable {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    };
  };
}
