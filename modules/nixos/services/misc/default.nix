{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.services.misc;
in {
  options.services.misc = with types; {
    enable = mkBoolOpt false "Enable/disable miscellaneous services";
  };
  config = mkIf cfg.enable {
    services = {
      gvfs.enable = true;
      dbus.enable = true;
      udev.enable = true;
      envfs.enable = true;
      fwupd.enable = true;
      tumbler.enable = true;
      tailscale.enable = true;
      flatpak.enable = true;
    };
  };
}
