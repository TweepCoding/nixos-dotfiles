{
  programs.nixvim = {
    plugins.oil = {
      enable = true;
      settings = {
        view_options = {
          show_hidden = true;
        };
      };
    };
    keymaps = [
      {
        mode = "n";
        key = "-";
        action = ":Oil<CR>";
        options = {
          desc = "[-] Go into Oil tree view";
        };
      }
    ];
  };
}
