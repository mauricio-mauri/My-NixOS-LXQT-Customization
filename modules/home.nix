{ ... }:

let
  # Home Manager pinado na mesma versão do canal nixos-26.05.
  # Para trocar pelo canal, substitua este bloco por: imports = [ <home-manager/nixos> ];
  home-manager = builtins.fetchTarball {
    url = "https://github.com/nix-community/home-manager/archive/release-26.05.tar.gz";
    sha256 = "sha256-AM1HmBeDnB2B3dSiXuCYeu7Me+lHNpz/P39lVxGJBuQ=";
  };

  dotfiles = ../dotfiles;

  # Os links antigos (criados pelo modules/dotfiles.nix, já removido) apontam
  # para o repositório. force = true substitui esses links pelos do Home Manager.
  managed = source: { inherit source; force = true; };
in
{
  imports = [ "${home-manager}/nixos" ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    # Faz backup de arquivos regulares que o Home Manager precise substituir.
    backupFileExtension = "hm-backup";

    users.mauri = { config, lib, ... }: {
      home.stateVersion = "26.05";

      home.file = {
        ".zshrc" = managed (dotfiles + "/zsh/.zshrc");
        ".fzf.zsh" = managed (dotfiles + "/zsh/.fzf.zsh");
        ".vimrc" = managed (dotfiles + "/vim/.vimrc");
      };

      xdg.configFile = {
        "nvim/init.vim" = managed (dotfiles + "/vim/.vimrc");
        "alacritty/alacritty.toml" = managed (dotfiles + "/alacritty/alacritty.toml");
        "alacritty/themes" = managed (dotfiles + "/alacritty/themes");
        "zellij/config.kdl" = managed (dotfiles + "/zellij/config.kdl");
        "mdcat/config.toml" = managed (dotfiles + "/mdcat/config.toml");
        "opencode/cli.json" = managed (dotfiles + "/opencode/cli.json");
        "git/config" = managed (dotfiles + "/git/config");

        "i3/config".source = dotfiles + "/i3/config";
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
