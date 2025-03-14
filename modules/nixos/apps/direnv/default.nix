{
  options,
  config,
  lib,
  ...
}:
with lib;
with lib.custom;
let
  cfg = config.apps.direnv;
in
{
  options.apps.direnv = with types; {
    enable = mkBoolOpt false "Enable direnv";
  };

  config = mkIf cfg.enable {
    home.programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableNushellIntegration = true;
    };

    environment.sessionVariables.DIRENV_LOG_FORMAT = ""; # Blank so direnv will shut up

    home.persist.directories = [ ".local/share/direnv" ];
  };
}
