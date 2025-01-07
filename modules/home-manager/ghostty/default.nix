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
      background-opacity = 0.95;
      resize-overlay-position = "bottom-right";
    };
  };
}
