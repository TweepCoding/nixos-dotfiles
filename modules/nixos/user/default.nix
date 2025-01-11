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
    name = mkOpt str "iogamaster" "The name to use for the user account.";
    initialPassword =
      mkOpt str "password"
        "The initial password to use when the user is first created.";
    extraGroups = mkOpt (listOf str) [ ] "Groups for the user to be assigned.";
    extraOptions = mkOpt attrs { } "Extra options passed to <option>users.users.<name></option>.";
  };

  config = {

    environment.sessionVariables.FLAKE = "/home/${cfg.name}/.config/nixos";

    users.users.${cfg.name} = {
      isNormalUser = true;
      inherit (cfg) name initialPassword;
      home = "/home/${cfg.name}";
      group = "users";
      shell = pkgs.fish;

      # TODO: Check out hashing password inside sops-nix
      # hashedPasswordFile = lib.mkForce config.sops.secrets."system/password".path;

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

    # TODO: Check out hashing password inside sops-nix
    # users.users.root.hashedPasswordFile = lib.mkForce config.sops.secrets."system/password".path;

    users.mutableUsers = false;
  };
}
