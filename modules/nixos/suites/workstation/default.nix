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
    apps.ghostty.enable = true;
    apps.obs.enable = true;

    suites.common.enable = true;
    services.mpris.enable = true;

    system.security.polkit.enable = true;

    programs.adb.enable = true;
    users.users.${config.user.name}.extraGroups = [ "adbusers" ];

    environment.systemPackages = with pkgs; [
      wlvncc
      nemo
      xclip
      xarchiver
      grim
      grimblast
      hyprpolkitagent
      libreoffice
      blueman
      filezilla
      qbittorrent
      thunderbird
      zathura
      slurp
      texliveFull
      postgresql # No service running, use docker for that
      keepassxc
      schemaspy # Testing
    ];
  };
}
