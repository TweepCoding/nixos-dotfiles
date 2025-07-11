{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.suites.development;
in {
  options.suites.development = with types; {
    enable = mkBoolOpt false "Enable the development suite";
  };

  config = mkIf cfg.enable {
    suites.common.enable = true;

    virtualisation.docker.enable = true;

    # Docker is slowing down my boot time, so while this is nice, I'll disable it
    virtualisation.docker.enableOnBoot = false;

    environment.systemPackages = with pkgs; [
      pgadmin4-desktopmode
      nushell
      lazygit
      nodejs_22
      yarn
      pnpm
      awscli2
      postman
      newman
      python314
      wrangler
      uv
      go
      terraform
      bruno
      google-cloud-sdk
      rustup
      neovim
    ];
  };
}
