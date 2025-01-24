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
  cfg = config.suites.workstation;
in
{
  options.suites.workstation = with types; {
    enable = mkBoolOpt false "Enable the workstation suite";
  };

  config = mkIf cfg.enable {
    desktop.hypr = {
      hyprland.enable = true;
      hyprpaper.enable = true;
      hypridle.enable = true;
      hyprlock.enable = true;
    };

    desktop.greetd.enable = true;

    apps.zen.enable = true;
    apps.vesktop.enable = true;

    suites.common.enable = true;

    system.security.polkit.enable = true;

    environment.systemPackages = with pkgs; [
      wlvncc
      nemo
      obs-studio
      xclip
      xarchiver
      grim
      grimblast
      hyprpolkitagent
      libreoffice
      filezilla
      qbittorrent
      thunderbird
      slurp
    ];
  };
}
