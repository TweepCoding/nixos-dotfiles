{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:
with lib;
with lib.custom;
{
  imports = [ inputs.sops-nix.nixosModules.sops ];

  config = {
    sops = {
      defaultSopsFile = ../../../../../secrets/secrets.yaml;
      defaultSopsFormat = "yaml";

      age.keyFile = "/home/${config.user.name}/.config/sops/age/keys.txt";

      secrets = {
        "userspace/ssh/online_profile/private_key" = {
          key = "ssh/online_profile/private_key";
          path = "/home/${config.user.name}/.ssh/online_key";
          owner = config.user.name;
          mode = "0600";
        };
        "userspace/ssh/online_profile/public_key" = {
          key = "ssh/online_profile/public_key";
          path = "/home/${config.user.name}/.ssh/online_key.pub";
          owner = config.user.name;
          mode = "0644";
        };
        "userspace/ssh/offline_profile/private_key" = {
          key = "ssh/offline_profile/private_key";
          path = "/home/${config.user.name}/.ssh/offline_key";
          owner = config.user.name;
          mode = "0600";
        };
        "userspace/ssh/offline_profile/public_key" = {
          key = "ssh/offline_profile/public_key";
          path = "/home/${config.user.name}/.ssh/offline_key.pub";
          owner = config.user.name;
          mode = "0644";
        };
        "system/ssh/online_profile/private_key" = {
          key = "ssh/online_profile/private_key";
          path = "/root/.ssh/online_key";
          owner = "root";
          mode = "0600";
        };
        "system/ssh/online_profile/public_key" = {
          key = "ssh/online_profile/public_key";
          path = "/root/.ssh/online_key.pub";
          owner = "root";
          mode = "0644";
        };
        "system/ssh/offline_profile/private_key" = {
          key = "ssh/offline_profile/private_key";
          path = "/root/.ssh/offline_key";
          owner = "root";
          mode = "0600";
        };
        "system/ssh/offline_profile/public_key" = {
          key = "ssh/online_profile/public_key";
          path = "/root/.ssh/offline_key.pub";
          owner = "root";
          mode = "0644";
        };
        "git/config/online_profile" = {
          path = "/home/${config.user.name}/.config/git/config-online";
          owner = config.user.name;
          mode = "0600";
        };
        "git/config/offline_profile" = {
          path = "/home/${config.user.name}/.config/git/config-offline";
          owner = config.user.name;
          mode = "0600";
        };
      };
    };
    environment.systemPackages = with pkgs; [
      (writeShellScriptBin "sops" ''
        EDITOR=${config.environment.variables.EDITOR} ${pkgs.sops}/bin/sops $@
      '')
      age
    ];
  };
}
