{
  options,
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib;
with lib.custom;
let
  cfg = config.suites.creation;
in
{
  options.suites.creation = with types; {
    enable = mkBoolOpt false "Enable the creation suite";
  };

  config = mkIf cfg.enable {
    suites.common.enable = true;

    environment.systemPackages = with pkgs; [
      kdePackages.kdenlive
      bitwig-studio5-latest
      gdtoolkit_4
      godot_4
      godot_4-export-templates
      neuralnote
      aseprite
    ];
  };
}
