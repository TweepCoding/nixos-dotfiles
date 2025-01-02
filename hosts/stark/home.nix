{ userSettings, ... }:
{
  imports = [
    ../../modules/home-manager/nvim/nixvim.nix

    ../../modules/home-manager/hypr/hypridle
    ../../modules/home-manager/hypr/hyprland
    ../../modules/home-manager/hypr/hyprpaper
    ../../modules/home-manager/hypr/hyprlock

    ../../modules/home-manager/dunst
    ../../modules/home-manager/waybar
    ../../modules/home-manager/starship
    ../../modules/home-manager/rofi
    ../../modules/home-manager/git
    ../../modules/home-manager/ssh
  ];

  home = {
    username = userSettings.username;
    homeDirectory = "/home/${userSettings.username}";

    stateVersion = "24.11";
    packages = [ ];

    file = {
      background = {
        source = ../../images/background.png;
        target = "./Pictures/background.png";
      };
      profilePicture = {
        source = ../../images/pfp.png;
        target = "./.config/pfp.png";
      };
    };

    sessionVariables = {
      FZF_DEFAULT_OPTS = ''
        --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
                --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
                --color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
                --color=selected-bg:#45475a \
                --multi'';
      EDITOR = "nvim";
    };
  };

  xdg = {
    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };

  programs = {
    home-manager.enable = true;
  };

}
