{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      update = "sudo nixos-rebuild switch --flake ~/.mynixos#nixos";
      edit = "sudo nvim ~/.mynixos";
    };

    initContent = ''
      export EDITOR="nvim"
      export VISUAL="nvim"
      export PATH="$HOME/.opencode/bin:$PATH"

      autoload -U promptinit
      promptinit
      prompt pure
    '';
  };

  home.packages = with pkgs; [
    pure-prompt
  ];
}
