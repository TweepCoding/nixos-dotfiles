{ pkgs, systemSettings, ... }:

pkgs.writeScriptBin "nixedit" ''
  #!/usr/bin/env fish

  # Move to the NixOS configuration directory
  pushd ~/.config/nixos/ > /dev/null

  # Open the editor
  nvim

  # Stage and commit the changes
  git add .
  if not git commit -m "Pre-rebuild: Updated NixOS configuration"
      echo "No changes to commit. Aborting."
      popd > /dev/null
      exit 1
  end

  # Perform the rebuild
  if not nixos-rebuild --use-remote-sudo switch --flake .#${systemSettings.hostname}
      echo "Rebuild failed or interrupted. Marking the commit."
      git commit --amend -m "Failed Pre-rebuild: Updated NixOS configuration"
      popd > /dev/null
      exit 1
  end

  # Return to the original directory
  popd > /dev/null
''
