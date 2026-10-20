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
    # opencode
	bat
    pure-prompt
    fzf
    zoxide
    zellij
    oh-my-zsh
    mdcat
  ];

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  programs.zsh.ohMyZsh = {
    enable = true;
    theme = "refined";
  };
}
