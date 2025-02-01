{
  lib,
  ...
}:
{
  imports = [ ./hardware-configuration.nix ];

  system.boot.efi.enable = true;

  suites = {
    laptop.enable = true;
    development.enable = true;
    creation.enable = true;
  };

  apps.misc = {
    enableBtrfs = true;
    enableBattery = true;
    enableBrightness = true;
  };

  zramSwap.enable = true;

  desktop.hypr.hyprland.disableTrackpad = true;
  nixpkgs.config.allowUnfree = true;

  networking.interfaces.wlp3s0 = {
    name = "wlp3s0";
    useDHCP = lib.mkDefault true;
  };

  # ==================== plz no touchy thanku ==================
  system.stateVersion = "24.11";
  # ==================== plz no touchy thanku ==================

}
