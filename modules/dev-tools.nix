{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    wget
    curl
    htop
    unzip
    ripgrep
    fd
    gcc
    gnumake
    fastfetch
    tree
    jq
    yq-go
    file
    opencode
    pure-prompt
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };
}
