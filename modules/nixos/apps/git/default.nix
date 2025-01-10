{ lib, ... }:
with lib;
with lib.custom;
let
  cfg = config.apps.git;
in
{
  options.apps.git = with types; {
    enable = mkBoolOpt true "Enable/disable git";
  };

  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
      delta.enable = true;
      includes = [
        {
          path = "/home/${config.user.name}/.config/git/config-offline";
        }
        {
          path = "/home/${config.user.name}/.config/git/config-online";
          condition = "gitdir:/home/${config.user.name}/Programming/online_profile/";
        }
        {
          path = "/home/${config.user.name}/.config/git/config-online";
          condition = "gitdir:/home/${config.user.name}/.config/nixos/";
        }
      ];
      maintenance.enable = true;
      extraConfig = {
        init.defaultBranch = "main";
      };
    };
  };
}
