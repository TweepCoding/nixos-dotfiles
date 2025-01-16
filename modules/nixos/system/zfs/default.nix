{
  options,
  config,
  lib,
  ...
}:
with lib;
with lib.custom;
let
  cfg = config.system.zfs;
in
{
  options.system.zfs = with types; {
    enable = mkBoolOpt false "Whether or not to configure zfs.";
  };

  config = mkIf cfg.enable {
    boot.supportedFilesystems = [ "zfs" ];
    boot.zfs.forceImportRoot = false;
    networking.hostId = "7b2d1504";
  };
}
