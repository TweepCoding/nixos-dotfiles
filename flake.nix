{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixos-hardware,
      home-manager,
      sops-nix,
      ...
    }@inputs:
    let
      inherit (self) outputs;
      systemSettings = {
        system = "x86_64-linux";
        hostname = "stark";
        timezone = "America/Bogota";
        locale = "en_US.UTF-8";
      };
      userSettings = {
        name = "Tweep";
        username = "tweep";
        wm = "hyprland";
        browser = "zen";
        fileManager = "thunar";
        term = "ghostty";
        font = "JetBrainsMono Nerd Font Mono";
        editor = "nvim";
      };
    in
    {
      nixosConfigurations.${systemSettings.hostname} = nixpkgs.lib.nixosSystem {
        system = systemSettings.system;
        specialArgs = {
          inherit systemSettings;
          inherit userSettings;
          inherit inputs;
          inherit outputs;
        };
        modules =
          [
            ./hosts/stark/configuration.nix
            home-manager.nixosModules.default
            sops-nix.nixosModules.sops
          ]
          ++ (
            if systemSettings.hostname == "stark" then
              [ nixos-hardware.nixosModules.lenovo-thinkpad-t14-amd-gen2 ]
            else
              [ ]
          );
      };
    };
}
