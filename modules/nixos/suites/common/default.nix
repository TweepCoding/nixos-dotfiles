{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom;
let
  cfg = config.suites.common;
in
{
  options.suites.common = with types; {
    enable = mkBoolOpt false "Enable/disable the common suite";
  };

  config = mkIf cfg.enable {

    hardware.audio.enable = true;
    hardware.networking.enable = true;

    hardware.bluetooth.enable = true;
    hardware.bluetooth.settings = {
      General = {
        FastConnectable = true;
        JustWorksRepairing = "always";
        Privacy = "device";
        Experimental = true;
      };
      Policy = {
        AutoEnable = true;
      };
      inputs = {
        UserSpaceHID = true;
      };
    };

    apps = {
      misc.enable = true;

      git.enable = true;
      nix-ld.enable = true;
      starship.enable = true;
      fish.enable = true;
      ghostty.enable = true;
      gpupg.enable = true;
    };

    services.ssh.enable = true;
    services.misc.enable = true;

    programs.dconf.enable = true;

    environment.systemPackages = [
      pkgs.custom.nixedit
    ];

    system = {
      fonts.enable = true;
      locale.enable = true;
      nix.enable = true;
      time.enable = true;
      xkb.enable = true;
      zfs.enable = true;
    };
  };
}
