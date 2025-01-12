{
  options,
  config,
  lib,
  inputs,
  ...
}:
with lib;
with lib.custom;
let
  cfg = config.apps.nix-ld;
in
{
  imports = with inputs; [ nix-ld.nixosModules.nix-ld ];
  options.apps.nix-ld = with types; {
    enable = mkBoolOpt false "Enable nix-ld";
  };

  config = mkIf cfg.enable { programs.nix-ld.enable = true; };
}
