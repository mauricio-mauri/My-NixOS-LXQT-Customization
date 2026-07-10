{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    neovim
    wget
    curl
    htop
    unzip
    ripgrep
    fd
    gcc
    gnumake
  ];
}
