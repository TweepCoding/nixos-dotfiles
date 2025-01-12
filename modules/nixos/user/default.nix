{
  options,
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.custom;
let
  cfg = config.user;
in
{
  options.user = with types; {
    name = mkOpt str "tweep" "The name to use for the user account.";
    extraGroups = mkOpt (listOf str) [ ] "Groups for the user to be assigned.";
    extraOptions = mkOpt attrs { } "Extra options passed to <option>users.users.<name></option>.";
  };

  config = {

    environment.sessionVariables.FLAKE = "/home/${cfg.name}/.config/nixos";

    users.users.${cfg.name} = {
      isNormalUser = true;
      inherit (cfg) name;
      home = "/home/${cfg.name}";
      group = "users";
      shell = pkgs.fish;

      # TODO: Check out hashing password inside sops-nix
      hashedPasswordFile = lib.mkForce config.sops.secrets."user/password".path;

      extraGroups = [
        "wheel"
        "audio"
        "sound"
        "video"
        "networkmanager"
        "input"
        "tty"
        "docker"
      ] ++ cfg.extraGroups;
    } // cfg.extraOptions;

    users.users.root.hashedPassword = "!";
    users.mutableUsers = false;
  };
}
