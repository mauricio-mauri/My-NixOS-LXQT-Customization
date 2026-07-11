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

    initContent = ''
      export EDITOR="nvim"
      export VISUAL="nvim"
    '';
  };
}
