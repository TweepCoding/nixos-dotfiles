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
  cfg = config.suites.laptop;
in
{
  options.suites.laptop = with types; {
    enable = mkBoolOpt false "Enable the laptop suite";
  };

  config = mkIf cfg.enable {
    suites.workstation.enable = true;

    apps.misc = {
      enableBtrfs = true;
      enableBattery = true;
      enableBrightness = true;
    };

    environment.systemPackages = with pkgs; [
      lutris
    ];
  };
}
