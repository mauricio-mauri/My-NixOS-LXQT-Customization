{ config, pkgs, ... }:

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
  ];

  system.stateVersion = "25.11";
}
