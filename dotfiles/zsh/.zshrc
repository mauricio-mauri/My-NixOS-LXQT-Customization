# Oh My Zsh e zoxide são carregados pelo NixOS em /etc/zshrc
# (configurados em modules/dev-tools.nix); não repetir aqui.

bindkey -e

export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# OpenCode instalado pelo instalador oficial (curl)
export PATH=$HOME/.opencode/bin:$PATH

[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

[ -d /usr/lib/jvm/java-21-openjdk-amd64 ] && export JAVA_HOME="/usr/lib/jvm/java-21-openjdk-amd64"

# Aliases
alias edit="nvim ~/My-NixOS-LXQT-Customization/"

# update: rebuild do NixOS e, se der certo, recarrega a interface LXQt:
# - openbox --reconfigure: o Openbox ree a configuracao (atalhos, decoracao).
# - reinicia o lxqt-panel: reaplica tema/icones do painel e rele o menu de
#   aplicativos. Se o lxqt-session nao relancar o painel, sobe manualmente.
update() {
  sudo nixos-rebuild switch -I nixos-config="/home/mauri/My-NixOS-LXQT-Customization/configuration.nix" || return $?

  openbox --reconfigure

  # O painel pode aparecer na lista de processos como
  # "/run/current-system/sw/bin/lxqt-panel" (sessao) ou "lxqt-panel" (manual).
  local pid
  pid=$(pgrep -f '(^|/)lxqt-panel$' | head -1)
  [ -n "$pid" ] && kill "$pid"
  sleep 2
  if ! pgrep -f '(^|/)lxqt-panel$' >/dev/null; then
    nohup lxqt-panel >/dev/null 2>&1 &
    sleep 3
  fi
  pgrep -f '(^|/)lxqt-panel$' >/dev/null && echo "lxqt-panel recarregado." \
    || echo "AVISO: lxqt-panel nao voltou; rode 'lxqt-panel' manualmente."
}

# LXQt: os arquivos sao copiados (nao linkados), porque o LXQt os reescreve.
# panel.conf e lxqt-config-monitor.conf ficam de fora: contem caminhos do
# /nix/store e geometria de monitores, que mudam entre builds e maquinas.
lxqt-save() {
  local repo=~/My-NixOS-LXQT-Customization/dotfiles/lxqt
  local f
  for f in ~/.config/lxqt/*.conf; do
    case "$(basename "$f")" in
      panel.conf|lxqt-config-monitor.conf) continue ;;
    esac
    cp -f "$f" "$repo/"
  done
}
lxqt-apply() {
  cp -f ~/My-NixOS-LXQT-Customization/dotfiles/lxqt/*.conf ~/.config/lxqt/
}

# Zellij: abre automaticamente ao iniciar o terminal e fecha o terminal ao encerrar a sessão
export ZELLIJ_AUTO_EXIT=true
eval "$(zellij setup --generate-auto-start zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# fnm
FNM_PATH="$HOME/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "$(fnm env --shell zsh)"
fi
