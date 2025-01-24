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

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 64 * 1024;
    }
  ];

  zramSwap.enable = true;

  desktop.hypr.hyprland.disableTrackpad = true;

  services.jellyfin-custom.enable = true;
  services.logind.enable = true;

  nixpkgs.config.allowUnfree = true;

  networking.interfaces.wlp6s0 = {
    name = "wlp6s0";
    useDHCP = lib.mkDefault true;
  };

  # ==================== plz no touchy thanku ==================
  system.stateVersion = "24.11";
  # ==================== plz no touchy thanku ==================

}
