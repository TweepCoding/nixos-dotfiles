{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
with lib.custom;
let
  cfg = config.apps.fish;
in
{
  options.apps.fish = with types; {
    enable = mkBoolOpt true "Enable/disable fish";
  };
  config = mkIf cfg.enable {
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        	set fish_greeting
        	function search_dirs
        		cd "$HOME/Programming"
        		fd --type d --exclude __pycache__ --exclude CMakeFiles --exclude src --no-require-git \
        		| awk '{print length($0), $0}' \
        		| sort -n \
        		| cut -d' ' -f2- \
        		| fzf --preview=\'cd {} && eza --color=always --oneline\'
        	end
        	${pkgs.starship}/bin/starship init fish | source
        	'';
      shellAliases = {
        vite = "yarn create vite";
        nixpublish = "git -C ~/.config/nixos/ push origin main";
        fastfetch = "fastfetch --logo .config/nixos/images/nixos.png --logo-type kitty-direct";
        ls = "eza";
	lg = "lazygit";
        ff = "fastfetch --logo .config/nixos/images/nixos.png --logo-type kitty-direct";
        p = "cd ~/Programming/(search_dirs) && tmux";
      };
    };
  };
}
