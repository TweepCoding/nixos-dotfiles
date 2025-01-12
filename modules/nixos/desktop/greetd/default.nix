{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.custom;
let
  cfg = config.desktop.greetd;
in
{
  options.desktop.greetd = with types; {
    enable = mkBoolOpt false "Enable or disable greetd";
  };

  config = mkIf cfg.enable {
    services.greetd = {
      enable = true;
      vt = 3;
      settings = rec {
        initial_session = {
          user = config.user.name;
          command = "${pkgs.hyprland}/bin/Hyprland";
        };
        default_session = initial_session;
      };
    };
  };
}
