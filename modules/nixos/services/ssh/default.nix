{ lib, config, ... }:
with lib;
with lib.custom;
let
  cfg = config.services.ssh;
in
{
  options.services.ssh = with types; {
    enable = mkBoolOpt true "Enable/disable ssh";
  };
  config = mkIf cfg.enable {
    home-manager.users.${config.user.name} = {
      programs.ssh = {
        enable = true;
        matchBlocks = {
          "github-online" = {
            hostname = "github.com";
            user = "git";
            identityFile = "/home/${config.user.name}/.ssh/online_key";
          };
          "github-offline" = {
            hostname = "github.com";
            user = "git";
            identityFile = "/home/${config.user.name}/.ssh/offline_key";
          };
          "github.com" = {
            hostname = "github.com";
            user = "git";
            identityFile = "/home/${config.user.name}/.ssh/offline_key";
          };
          "fern" = {
            hostname = "fern.ferret-ling.ts.net";
            user = "root";
            identityFile = "/home/${config.user.name}/.ssh/offline_key";
          };
          "okarun" = {
            hostname = "okarun.ferret-ling.ts.net";
            user = "asistente";
            identityFile = "/home/${config.user.name}/.ssh/offline_key";
          };
        };
      };
    };
  };
}
