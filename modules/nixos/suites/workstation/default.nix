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
    desktop.gtk.enable = true;

    apps.zen.enable = true;
    apps.vesktop.enable = true;
    apps.ghostty.enable = true;
    apps.obs.enable = true;
    apps.virtualbox.enable = true;

    suites.common.enable = true;

    services.mpris.enable = true;
    services.kanata-custom.enable = true;
    services.ollama-custom.enable = true;

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
      bitwarden-cli
      bitwarden-desktop
      postgresql # No service running, use docker for that
      pandoc
      keepassxc
      rclone
      onedrive
      schemaspy # Testing
      devenv
      direnv
      brave
    ];
  };
}
