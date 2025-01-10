{
  inputs,
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.custom;
let
  cfg = config.apps.misc;
in
{
  options.apps.misc = with types; {
    enable = mkBoolOpt true "Enable misc apps";
    enableExtra = mkBoolOpt true "Enable applications that are convenient but not required for regular usage";
    enableBtrfs = mkBoolOpt false "Enable btrfs related applications";
    enableBattery = mkBoolOpt false "Enable battery related applications";
    enableBrightness = mkBoolOpt false "Enable brightness related applications";
  };

  config = mkIf cfg.enable {
    environment.systemPackages =
      with pkgs;
      [
        btop
        cliphist
        curl
        duf # disk utility
        fastfetch
        ffmpeg
        gcc
        imagemagick
        killall
        libinput
        lutgen
        qt6.qtwayland
        qt6ct
        ripgrep
        sops
        swappy
        swaynotificationcenter
        tmux
        unzip
        wget
        wl-clipboard
        wlogout
        xdg-user-dirs
        xdg-utils
      ]
      ++ lib.optional (cfg.enableExtra) [
        eza
        fzf
        fd
        testdisk
        yt-dlp
      ]
      ++ lib.optional (cfg.enableBtrfs) [
        btrfs-progs # tools to use btrfs with
      ]
      ++ lib.optional (cfg.enableBattery) [
        cpufrequtils # battery management
      ]
      ++ lib.optional (cfg.enableBrightness) [
        brightnessctl
      ];
  };
}
