{
  programs.nixvim = {
    plugins.none-ls = {
      enable = true;
      sources = {
        diagnostics.markdownlint.enable = true;
        formatting.black.enable = true;
        formatting.prettierd.enable = true;
      };
    };
  };
}
