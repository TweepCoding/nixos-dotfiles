{
  programs.rofi = {
    enable = true;
  };

  home.file = {
    ".config/rofi" = {
      source = ./rofi;
      recursive = true;
    };
  };
}
