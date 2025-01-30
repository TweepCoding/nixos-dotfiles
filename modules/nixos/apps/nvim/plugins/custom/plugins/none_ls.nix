{
  programs.nixvim = {
    plugins.none-ls = {
      enable = true;
      sources.diagnostics.markdownlint.enable = true;
    };
  };
}
