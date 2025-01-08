# edit this configuration file to define what should be installed on
# your system. help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the nixos manual (`nixos-help`).

{
  userSettings,
  systemSettings,
  pkgs,
  inputs,
  ...
}:

let
  nix-edit-script = import ../../modules/nixos/nixedit { inherit pkgs systemSettings; };
in
{
  imports = [
    # include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../modules/nixos/sops
    ../../modules/nixos/fish
    ../../modules/nixos/virtualisation
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = systemSettings.hostname;
  networking.networkmanager.enable = true;

  time.timeZone = systemSettings.timezone;

  i18n.defaultLocale = systemSettings.locale;
  console = {
    font = "${pkgs.terminus_font}/share/consolefonts/ter-i24n.psf.gz";
    packages = with pkgs; [ terminus_font ];
    keyMap = "us";
  };

  users.users.${userSettings.username} = {
    isNormalUser = true;
    initialPassword = userSettings.username;
    description = userSettings.name;
    shell = pkgs.fish;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  nixpkgs.overlays = [ inputs.audio.overlays.default ];

  environment.systemPackages = with pkgs; [
    btrfs-progs # tools to use btrfs with
    curl
    cpufrequtils # battery management
    duf # disk utility
    ffmpeg
    git
    gcc
    ripgrep
    killall
    xdg-user-dirs
    xdg-utils
    fastfetch
    btop
    brightnessctl
    cliphist
    grim
    imagemagick
    alacritty
    networkmanagerapplet
    nwg-look # gtk3 theme settings editor
    pamixer
    pavucontrol
    pyprland # plugins for hyprland
    qt6ct
    qt6.qtwayland
    rofi-wayland
    slurp
    swappy
    swaynotificationcenter
    swww
    unzip
    wallust # better pywal
    wl-clipboard
    wlogout
    yad # cli GTK+ dialogs for scripting
    yt-dlp
    neovim
    fish
    tmux
    fzf
    fd
    eza
    oh-my-posh
    wget
    inputs.zen-browser.packages."${pkgs.system}".default # zen browser
    libinput
    rofi-wayland
    vesktop
    hyprpolkitagent
    nixfmt-rfc-style
    pamixer
    sops
    nix-index
    nix-edit-script
    lutgen
    testdisk
    neuralnote
    bitwig-studio5-latest
    godot_4
    godot_4-export-templates
    gdtoolkit_4
    grimblast
  ];

  programs = {
    hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage =
        inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
      xwayland.enable = true;
    };
    waybar.enable = true;
    hyprlock.enable = true;
    nm-applet.indicator = true;
    thunar.enable = true;
    thunar.plugins = with pkgs.xfce; [
      exo
      mousepad
      thunar-archive-plugin
      thunar-volman
      tumbler
    ];
    xwayland.enable = true;
    dconf.enable = true;
    fuse.userAllowOther = true;
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  services = {
    xserver = {
      enable = false;
      xkb = {
        layout = "us";
        variant = "";
      };
    };
    greetd = {
      enable = true;
      vt = 3;
      settings = rec {
        initial_session = {
          user = userSettings.username;
          command = "${pkgs.hyprland}/bin/Hyprland";
        };
        default_session = initial_session;
      };
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
      jack.enable = true;
    };
    libinput.enable = true;

    gvfs.enable = true;
    dbus.enable = true;
    udev.enable = true;
    envfs.enable = true;

    fstrim = {
      enable = true;
      interval = "weekly";
    };

    blueman.enable = true;
    fwupd.enable = true;
    upower.enable = true;

    tumbler.enable = true;
  };

  xdg.portal = {
    enable = true;
    wlr.enable = false;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
    configPackages = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal
    ];
  };

  users.mutableUsers = true;

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs systemSettings userSettings; };
    users = {
      "${userSettings.username}" = import ./home.nix;
    };
  };

  zramSwap = {
    enable = true;
    priority = 100;
    memoryPercent = 30;
    swapDevices = 1;
    algorithm = "zstd";
  };

  powerManagement = {
    enable = true;
    cpuFreqGovernor = "schedutil";
  };

  nix = {
    settings = {
      auto-optimise-store = true;
      substituters = [ "https://hyprland.cachix.org" ];
      trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  hardware = {
    graphics.enable = true;
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
          Experimental = true;
        };
      };
    };
  };

  security = {
    rtkit.enable = true;
    polkit = {
      enable = true;
      extraConfig = ''
        	polkit.addRule(function(action, subject) {
        		if (
        			subject.isInGroup("users")
        		&&
        			action.id == "org.freedesktop.login1.reboot" ||
        			action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
        			action.id == "org.freedesktop.login1.power-off" ||
        			action.id == "org.freedesktop.login1.power-off-multiple-sessions"
        		)
        		{
        			return polkit.Result.YES;
        		}
        	})
        			'';
    };
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  nixpkgs.config.allowUnfree = true;

  # this option defines the first version of nixos you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older nixos versions.
  #
  # most users should never change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new nixos release.
  #
  # this value does not affect the nixpkgs version your packages and os are pulled from,
  # so changing it will not upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # this value being lower than the current nixos release does not mean your system is
  # out of date, out of support, or vulnerable.
  #
  # do not change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # for more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateversion .

  system.stateVersion = "24.11"; # did you read the comment?

}
