{
  lib,
  config,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.desktop.waybar;
in {
  options.desktop.waybar = with types; {
    enable = mkBoolOpt true "Enable/disable waybar";
  };
  config = mkIf cfg.enable {
    home-manager.users.${config.user.name} = {
      programs.waybar = {
        enable = true;
        settings = {
          mainBar = {
            layer = "top";
            modules-left = [
              "custom/nixos"
              "hyprland/workspaces"
            ];
            modules-center = ["clock"];
            modules-right = [
              "custom/vpn"
              "backlight"
              "pulseaudio"
              "bluetooth"
              "network"
              "battery"
            ];
            margin-left = 9;
            margin-right = 9;
            margin-top = 5;
            margin-down = 5;

            "custom/nixos" = {
              format = "  ";
              tooltip = false;
            };
            "hyprland/workspaces" = {
              format = "{icon}";
              tooltip = false;
              active-only = false;
              all-outputs = true;

              format-icons = {
                "active" = "";
                "default" = "";
                "persistent" = "";
                "empty" = "";
              };
              persistent-workspaces."*" = 6;
            };
            "custom/vpn" = {
              format = "VPN 󱂇 ";
              exec = "echo '{\"class\": \"connected\"}'";
              exec-if = "test -d /proc/sys/net/ipv4/conf/tun0";
              return-type = "json";
              interval = 5;
            };
            clock = {
              interval = 30;
              format = "󰃭  {:%a %F, %I:%M %p}";
            };
            backlight = {
              device = "intel_backlight";
              format = "{icon} {percent}%";
              format-icons = [
                ""
                ""
                ""
                ""
                ""
                ""
                ""
                ""
                ""
              ];
            };
            pulseaudio = {
              format = "{icon} {volume}%";
              format-muted = "󰝟";
              tooltip = false;
              format-icons = {
                headphone = "";
                default = [
                  ""
                  ""
                  ""
                  ""
                  "󰕾"
                  "󰕾"
                  "󰕾"
                  "󰕾"
                ];
              };
              scroll-step = 1;
            };
            bluetooth = {
              format = " {status}";
              format-disabled = "";
              format-connected = " {num_connections} device(s)";
              tooltip-format = "{device_enumerate}";
              tooltip-format-enumerate-connected = "{device_alias} {device_address}";
            };
            network = {
              format-wifi = "󰖩 {essid} ({signalStrength}%)";
              format-linked = "󱚵 {essid} (No IP)";
              format-ethernet = "󰈀 {ifname}";
              tooltip-format = "{ifname} via {gwaddr}";
              format-disconnected = "󰖪 No Network";
              format-alt = "󰖩 {ifname}: {ipaddr}/{cidr}";
            };
            battery = {
              format = "{icon} {capacity}%";
              format-icons = [
                "󰁺"
                "󰁻"
                "󰁼"
                "󰁽"
                "󰁾"
                "󰁿"
                "󰂀"
                "󰂁"
                "󰂂"
                "󰁹"
              ];
              format-charging = "󰂄 {capacity}%";
              tooltip = false;
            };
          };
        };
        style = ./style.css;
        systemd = {
          enable = true;
        };
      };
    };
  };
}
