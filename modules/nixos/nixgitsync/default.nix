{ userSettings, pkgs, ... }:
{
  # Define the systemd service for syncing the NixOS config repository
  systemd.services.nixos-git-sync = {
    description = "Sync NixOS configuration repository on boot and shutdown";

    # Ensure network availability
    after = [ "network-online.target" ];
    requires = [ "network-online.target" ];

    # Run before system shutdown
    before = [ "shutdown.target" ];

    # Service configuration
    serviceConfig = {
      # Pull on startup
      ExecStart = "${pkgs.bash}/bin/bash -c ''
        REPO_PATH=$HOME/.config/nixos
        cd $REPO_PATH || exit
        git pull origin main
      ''";

      # Push on shutdown
      ExecStop = "${pkgs.bash}/bin/bash -c ''
        REPO_PATH=$HOME/.config/nixos
        cd $REPO_PATH || exit
        git add .
        git commit -m \"Auto commit before shutdown\"
        git push origin main
      ''";

      # Run as the current user
      User = userSettings.username; # Replace with your username
      WorkingDirectory = "/home/${userSettings.username}"; # Replace with your home directory
    };

    # Start the service during boot
    wantedBy = [ "multi-user.target" ];
  };
}
