{
  lib,
  ...
}:
{
  imports = [ ./hardware-configuration.nix ];

  system.boot.efi.enable = true;

  suites = {
    workstation.enable = true;
    development.enable = true;
    creation.enable = true;
  };

  desktop.hypr.hyprland = {
    disableTrackpad = false;
    mainMonitor = "HDMI-A-1";
  };

  nixpkgs.config.allowUnfree = true;

  networking.interfaces.wlp6s0 = {
    name = "wlp6s0";
    useDHCP = lib.mkDefault true;
  };

  # ==================== plz no touchy thanku ==================
  system.stateVersion = "24.11";
  # ==================== plz no touchy thanku ==================

}
