# Oh My Zsh e zoxide são carregados pelo NixOS em /etc/zshrc
# (configurados em modules/dev-tools.nix); não repetir aqui.

export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# OpenCode instalado pelo instalador oficial (curl)
export PATH=$HOME/.opencode/bin:$PATH

[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

[ -d /usr/lib/jvm/java-21-openjdk-amd64 ] && export JAVA_HOME="/usr/lib/jvm/java-21-openjdk-amd64"

# Aliases
alias edit="nvim ~/My-NixOS-LXQT-Customization/"
alias update="sudo nixos-rebuild switch -I nixos-config=\"/home/mauri/My-NixOS-LXQT-Customization/configuration.nix\""

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
