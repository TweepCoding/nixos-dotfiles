{
  services.hyprpaper = {
    enable = true;
    settings =
      let
        backgroundPicture = "~/Pictures/background.png";
      in
      {
        preload = backgroundPicture;
        wallpaper = [
          "eDP-1,${backgroundPicture}"
          "HDMI-A-1,${backgroundPicture}"
          "Virtual-1,${backgroundPicture}"
        ];
      };
  };
}
