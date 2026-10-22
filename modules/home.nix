{ ... }:

let
  # Home Manager pinado em um commit do branch release-26.05 (mesma versão do canal nixos-26.05).
  # Pinar o commit (e não o branch) evita que o hash quebre quando o branch avança.
  # Para trocar pelo canal, substitua este bloco por: imports = [ <home-manager/nixos> ];
  home-manager = builtins.fetchTarball {
    url = "https://github.com/nix-community/home-manager/archive/24f8f8e786f87d6a818e1746cb2389bf922afdab.tar.gz";
    sha256 = "sha256-5mQQOcggBRBXB7NlzUxO0dbvQN4euJOISjNybrtfxPk=";
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
        "autostart/cortile.desktop".source = dotfiles + "/autostart/cortile.desktop";
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

      # O cortile pode regravar o config.toml (ex.: pela bandeja), então ele
      # também é copiado apenas na primeira vez.
      home.activation.cortileConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        cortileDir="$HOME/.config/cortile"
        run mkdir -p "$cortileDir"
        if [ ! -e "$cortileDir/config.toml" ]; then
          run install -m 644 ${dotfiles}/cortile/config.toml "$cortileDir/config.toml"
        fi
      '';
    };
  };
}
