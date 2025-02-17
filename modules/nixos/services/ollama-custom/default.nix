{
  lib,
  config,
  pkgs,
  ...
}:
with lib;
with lib.custom;
let
  cfg = config.services.ollama-custom;
in
{
  options.services.ollama-custom = with types; {
    enable = mkBoolOpt false "Enable/disable Ollama";
  };
  config = mkIf cfg.enable {
    services.ollama = {
      enable = true;
      acceleration = false; # TODO: Set option to enable if using Eisen
    };
  };
}
