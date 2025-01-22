{
  programs.nixvim = {
    plugins.typescript-tools = {
      enable = true;
      settings = {
        settings.codeLens = "all";
        jsx_close_tag.enable = true;
      };
    };
  };
}
