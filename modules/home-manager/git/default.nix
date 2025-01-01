{ userSettings, ... }:
{
  programs.git = {
    enable = true;
    delta.enable = true;
    includes = [
      {
        path = "/home/${userSettings.username}/.config/git/config-offline";
      }
      {
        path = "/home/${userSettings.username}/.config/git/config-online";
        condition = "gitdir:/home/${userSettings.username}/Programming/online_profile/";
      }
      {
        path = "/home/${userSettings.username}/.config/git/config-online";
        condition = "gitdir:/home/${userSettings.username}/.config/nixos/";
      }
    ];
    maintenance.enable = true;
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}
