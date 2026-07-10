{ pkgs, ... }:

{
  imports = [
    ./shell.nix
    ./git.nix
    ./dev.nix
    ./packages.nix
  ];

  home.username = "mauri";
  home.homeDirectory = "/home/mauri";
  home.stateVersion = "25.11";
}
