{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/boot.nix
    ../../modules/desktop.nix
    ../../modules/locale.nix
    ../../modules/networking.nix
    ../../modules/audio.nix
    ../../modules/ssh.nix
    ../../modules/dev-tools.nix
    ../../modules/nix-config.nix
    ../../modules/users.nix
    ../../modules/flatpak.nix
    ../../modules/docker.nix
    ../../modules/fonts.nix
    ../../modules/bluetooth.nix
    ../../modules/dotfiles.nix
    # ../../modules/opencode.nix
  ];

  boot.loader.grub.device = "/dev/sda";
  hardware.enableRedistributableFirmware = true;

  system.stateVersion = "26.05";
}
