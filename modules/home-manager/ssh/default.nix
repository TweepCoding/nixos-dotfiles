{ userSettings, ... }:
{
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "github-online" = {
        hostname = "github.com";
        user = "git";
        identityFile = "/home/${userSettings.username}/.ssh/online_key";
      };
      "github-offline" = {
        hostname = "github.com";
        user = "git";
        identityFile = "/home/${userSettings.username}/.ssh/offline_key";
      };
      "github.com" = {
        hostname = "github.com";
        user = "git";
        identityFile = "/home/${userSettings.username}/.ssh/offline_key";
      };
    };
  };
}
