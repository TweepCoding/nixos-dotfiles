{ lib, ... }:
{
  virtualisation.vmVariant = {
    virtualisation = {
      memorySize = 8192; # Use 8192MiB memory.
      cores = 6;
      # Taken from https://github.com/donovanglover/nix-config/commit/0bf134297b3a62da62f9ee16439d6da995d3fbff
      # to enable Hyprland to work on a virtualized GPU.
      qemu.options = [
        "-device virtio-vga-gl"
        "-display sdl,gl=on,show-cursor=off"
        "-audiodev pipewire,id=audio0"
        "-device intel-hda"
        "-device hda-output,audiodev=audio0"
      ];
    };

    environment.sessionVariables = lib.mkVMOverride {
      WLR_NO_HARDWARE_CURSORS = "1";
    };
  };
}
