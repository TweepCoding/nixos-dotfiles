{
  programs.nixvim.plugins = {
    cmp.enable = true;
    copilot-lua.enable = true;
    mini = {
      enable = true;
      modules.pick = { };
    };
    web-devicons.enable = true;

    avante = {
      enable = true;
    };
  };
}
