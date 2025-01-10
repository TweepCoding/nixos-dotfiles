{ lib, ... }:
with lib;
with lib.custom;
let
  cfg = config.ssh;
in
{
  options.ssh = with types; {
    enable = mkBoolOpt true "Enable/disable ssh";
  };
  config = mkIf cfg.enable {
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
      };
    };
  };
}
