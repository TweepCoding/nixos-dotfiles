{
  userSettings,
  inputs,
  ...
}:
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];
  sops = {
    defaultSopsFile = ../../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";

    age.keyFile = "/home/${userSettings.username}/.config/sops/age/keys.txt";

    secrets = {
      "userspace/ssh/online_profile/private_key" = {
        key = "ssh/online_profile/private_key";
        path = "/home/${userSettings.username}/.ssh/online_key";
        owner = userSettings.username;
        mode = "0600";
      };
      "userspace/ssh/online_profile/public_key" = {
        key = "ssh/online_profile/public_key";
        path = "/home/${userSettings.username}/.ssh/online_key.pub";
        owner = userSettings.username;
        mode = "0644";
      };
      "userspace/ssh/offline_profile/private_key" = {
        key = "ssh/offline_profile/private_key";
        path = "/home/${userSettings.username}/.ssh/offline_key";
        owner = userSettings.username;
        mode = "0600";
      };
      "userspace/ssh/offline_profile/public_key" = {
        key = "ssh/offline_profile/public_key";
        path = "/home/${userSettings.username}/.ssh/offline_key.pub";
        owner = userSettings.username;
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
        path = "/home/${userSettings.username}/.config/git/config-online";
        owner = userSettings.username;
        mode = "0600";
      };
      "git/config/offline_profile" = {
        path = "/home/${userSettings.username}/.config/git/config-offline";
        owner = userSettings.username;
        mode = "0600";
      };
    };
  };
}
