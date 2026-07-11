# Troubleshooting

## Problemas Comuns

### 1. "error: undefined variable 'pkgs'"

**Causa**: Módulo não recebe `pkgs` como argumento.

**Solução**: Adicionar `{ pkgs, ... }:` na função do módulo:

```nix
# Errado
{ ... }:
{ users.users.mauri.shell = pkgs.zsh; }

# Correto
{ pkgs, ... }:
{ users.users.mauri.shell = pkgs.zsh; }
```

### 2. DMS não inicia — "Unrecognized pragma AppId"

**Causa**: quickshell versão antiga (0.2.1) não suporta pragma `AppId`.

**Solução**: Usar quickshell ≥0.3.0 do upstream flake:

```nix
# flake.nix
quickshell = {
  url = "github:quickshell-mirror/quickshell";
  inputs.nixpkgs.follows = "nixpkgs";
};

# modules/desktop.nix
programs.dank-material-shell.quickshell.package =
  inputs.quickshell.packages.${pkgs.system}.quickshell;
```

### 3. `enableSystemMonitoring` não cria nova geração

**Causa**: `enableSystemMonitoring` tem default `true` quando `enable = true`. Definir explicitamente é um no-op.

**Solução**: Remover a linha, pois já é o padrão.

### 4. `switch_layout` vs `switch_keyboard_layout`

**Erro comum**: Usar `switch_layout` para trocar layout de teclado.

- `switch_layout` — troca layout de **janelas** (tile/scroller/grid)
- `switch_keyboard_layout` — troca layout de **teclado** (us/br)

### 5. GRUB não mostra menu com Shift

**Causa**: Em sistemas EFI, a detecção de Shift pode não funcionar.

**Solução**: Usar `timeout = 1` em vez de `timeout = 0`:

```nix
boot.loader.timeout = 1;  # 1s de janela para Shift
```

### 6. Plymouth não aparece

**Causa**: `initrd.verbose` ou `consoleLogLevel` muito altos.

**Solução**: Verificar configuração silenciosa:

```nix
boot.consoleLogLevel = 3;
boot.initrd.verbose = false;
boot.kernelParams = [ "quiet" ];
```

### 7. Nerd-fonts não aparecem

**Causa**: Fonts instaladas mas fontconfig não as encontra.

**Solução**: Rebuild + logout/login para recarregar cache de fonts.

### 8. Zsh não inicia no login

**Causa**: `programs.zsh.enable = true` não está no nível NixOS.

**Solução**: Adicionar em `hosts/nixos/default.nix`:

```nix
programs.zsh.enable = true;
```

**Nota**: Isto é diferente do `programs.zsh.enable` do home-manager.

### 9. Home Manager cria `.backup` files

**Causa**: Conflito entre configuração anterior e nova.

**Solução**: Verificar e remover backups:

```bash
ls ~/.config/*.backup
rm ~/.config/*.backup
```

### 10. `sudo nixos-rebuild switch` usa config antiga

**Causa**: Executou sem `--flake`.

**Solução**: SEMPRE usar `--flake`:

```bash
# ERRADO
sudo nixos-rebuild switch

# CORRETO
sudo nixos-rebuild switch --flake .#nixos
# ou
update
```

## Comandos Úteis

```bash
# Verificar status do sistema
nixos-rebuild list-generations

# Verificar flakes
nix flake check
nix flake metadata

# Limpar store
nix store gc

# Verificar dependências
nix why-depends /run/current-system nixpkgs#vim

# Debug build
nixos-rebuild switch --flake .#nixos --show-trace
```

## Logs

```bash
# System journal
journalctl -xe

# Home Manager
journalctl --user -u home-manager-mauri

# DMS
dms run  # stdout/stderr

# MangoWM
cat ~/.local/share/mango/log
```
