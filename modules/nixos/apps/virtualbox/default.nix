{
  options,
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib;
with lib.custom;
let
  cfg = config.apps.virtualbox;
in
{
  options.apps.virtualbox = with types; {
    enable = mkBoolOpt false "Enable/disable virtualbox";
  };

  config = mkIf cfg.enable {
    virtualisation.virtualbox.host.enable = true;
    users.extraGroups.vboxusers.members = [ config.user.name ];
  };
}
