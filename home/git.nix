{ ... }:

{
  programs.git = {
    enable = true;
    userName = "Mauricio";
    userEmail = "mauri@example.com";
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };
}
