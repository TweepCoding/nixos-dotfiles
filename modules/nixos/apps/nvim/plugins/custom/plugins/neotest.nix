{
  programs.nixvim = {
    plugins.neotest = {
      enable = true;
      adapters = {
        python.enable = true;
        java.enable = true;
        jest.enable = true;
        vitest.enable = true;
        dart.enable = true;
      };
    };
  };
}
