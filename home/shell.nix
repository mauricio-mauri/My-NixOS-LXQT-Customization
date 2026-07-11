{ ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      theme = "pure";
      plugins = [ "git" "sudo" "docker" ];
    };

    shellAliases = {
      update = "sudo nixos-rebuild switch --flake ~/.mynixos#nixos";
      edit = "sudo nvim ~/.mynixos";
    };

    initContent = ''
      export EDITOR="nvim"
      export VISUAL="nvim"
    '';
  };
}
