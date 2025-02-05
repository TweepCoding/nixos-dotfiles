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
  cfg = config.suites.development;
in
{
  options.suites.development = with types; {
    enable = mkBoolOpt false "Enable the development suite";
  };

  config = mkIf cfg.enable {
    suites.common.enable = true;
    apps.nvim.enable = true;

    virtualisation.docker.enable = true;

    environment.systemPackages = with pkgs; [
      android-studio-full
      pgadmin4-desktopmode
      nushell
      lazygit
      nodejs_22
      yarn
      python314
      cargo
      rustc
      flutter
    ];
  };
}
