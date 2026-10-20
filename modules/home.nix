{ ... }:

let
  # Home Manager pinado na mesma versão do canal nixos-26.05.
  # Para trocar pelo canal, substitua este bloco por: imports = [ <home-manager/nixos> ];
  home-manager = builtins.fetchTarball {
    url = "https://github.com/nix-community/home-manager/archive/release-26.05.tar.gz";
    sha256 = "sha256-AM1HmBeDnB2B3dSiXuCYeu7Me+lHNpz/P39lVxGJBuQ=";
  };

  dotfiles = ../dotfiles;
in
{
  imports = [ "${home-manager}/nixos" ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    # Preserva os arquivos existentes na Home, que hoje são links
    # criados pelo antigo modules/dotfiles.nix.
    backupFileExtension = "hm-backup";

    users.mauri = { config, lib, ... }: {
      home.stateVersion = "26.05";

      home.file = {
        ".zshrc".source = dotfiles + "/zsh/.zshrc";
        ".fzf.zsh".source = dotfiles + "/zsh/.fzf.zsh";
        ".vimrc".source = dotfiles + "/vim/.vimrc";
      };

      xdg.configFile = {
        "nvim/init.vim".source = dotfiles + "/vim/.vimrc";
        "alacritty/alacritty.toml".source = dotfiles + "/alacritty/alacritty.toml";
        "alacritty/themes".source = dotfiles + "/alacritty/themes";
        "zellij/config.kdl".source = dotfiles + "/zellij/config.kdl";
        "mdcat/config.toml".source = dotfiles + "/mdcat/config.toml";
        "opencode/cli.json".source = dotfiles + "/opencode/cli.json";
        "git/config".source = dotfiles + "/git/config";
      };

      # O LXQt reescreve seus .conf quando você muda algo pela interface.
      # Por isso estes arquivos são copiados, não linkados: se fossem
      # symlinks para o store, a interface não conseguiria gravar.
      # A cópia só acontece se o arquivo ainda não existir, para não
      # apagar mudanças feitas pela GUI. Para propagar mudanças nos dois
      # sentidos, use os aliases lxqt-save e lxqt-apply.
      home.activation.lxqtConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        lxqtDir="$HOME/.config/lxqt"
        run mkdir -p "$lxqtDir"
        for src in ${dotfiles}/lxqt/*.conf; do
          name="$(basename "$src")"
          if [ ! -e "$lxqtDir/$name" ]; then
            run cp "$src" "$lxqtDir/$name"
          fi
        done
      '';
    };
  };
}
