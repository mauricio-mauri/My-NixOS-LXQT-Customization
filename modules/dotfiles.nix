{ ... }:

let
  dotfiles = "/home/mauri/My-NixOS-LXQT-Customization/dotfiles";
  link = path: source: "L+ ${path} - mauri users - ${dotfiles}/${source}";
in
{
  systemd.tmpfiles.rules = [
    "d /home/mauri/.config/nvim - mauri users -"
    "d /home/mauri/.config/git - mauri users -"

    (link "/home/mauri/.zshrc" "zsh/.zshrc")
    (link "/home/mauri/.fzf.zsh" "zsh/.fzf.zsh")

    (link "/home/mauri/.vimrc" "vim/.vimrc")
    (link "/home/mauri/.config/nvim/init.vim" "vim/.vimrc")

    (link "/home/mauri/.config/alacritty/alacritty.toml" "alacritty/alacritty.toml")
    (link "/home/mauri/.config/alacritty/themes" "alacritty/themes")

    (link "/home/mauri/.config/zellij/config.kdl" "zellij/config.kdl")
    (link "/home/mauri/.config/mdcat/config.toml" "mdcat/config.toml")
    (link "/home/mauri/.config/opencode/cli.json" "opencode/cli.json")
    (link "/home/mauri/.config/git/config" "git/config")
  ];
}
