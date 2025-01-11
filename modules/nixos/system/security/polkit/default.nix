{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom;
let
  cfg = config.system.security.polkit;
in
{
  options.system.security.polkit = with types; {
    enable = mkBoolOpt false "Enable polkit rules";
  };

  config = mkIf cfg.enable {
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
  };
}
