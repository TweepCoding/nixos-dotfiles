{ userSettings, ... }:
{
  programs.ghostty = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      theme = "catppuccin-mocha";
      font-size = 12;
      font-family = userSettings.font;
      window-decoration = false;
      resize-overlay-position = "bottom-right";
    };
  };
}
