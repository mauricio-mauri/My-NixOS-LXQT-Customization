{ ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user.name = "Mauricio";
      user.email = "mauri@example.com";
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };
}
