# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "usb_storage"
    "sd_mod"
    "rtsx_pci_sdmmc"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [
    "kvm"
    "kvm-amd"
    "virtio"
  ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/947c039c-b3c6-4221-b8ca-2c998c913b35";
    fsType = "btrfs";
    options = [ "subvol=rootfs" ];
  };

  fileSystems."/.swapvol" = {
    device = "/dev/disk/by-uuid/947c039c-b3c6-4221-b8ca-2c998c913b35";
    fsType = "btrfs";
    options = [ "subvol=swap" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/0C67-94E5";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/947c039c-b3c6-4221-b8ca-2c998c913b35";
    fsType = "btrfs";
    options = [ "subvol=home" ];
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/947c039c-b3c6-4221-b8ca-2c998c913b35";
    fsType = "btrfs";
    options = [ "subvol=nix" ];
  };

  fileSystems."/partition-root" = {
    device = "/dev/disk/by-uuid/947c039c-b3c6-4221-b8ca-2c998c913b35";
    fsType = "btrfs";
  };

  swapDevices = [ ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp2s0f0.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp5s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp3s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
