# Home Manager

## Visão Geral

Home Manager roda como um módulo NixOS (não standalone). As configurações do usuário ficam em `home/`.

## Ativação

Após `nixos-rebuild switch`, o home-manager ativa automaticamente via systemd:

```bash
# Verificar status
systemctl status home-manager-mauri.service

# Ativar manualmente
home-manager switch --flake ~/.mynixos#mauri
```

## Módulos

### Shell (home/shell.nix)

- **Zsh** como shell padrão
- **pure-prompt** para prompt minimalista
- **Autosuggestion** para sugestões baseadas em histórico
- **Syntax highlighting** para cores no terminal
- **Aliases**: `update` e `edit`

```nix
programs.zsh = {
  enable = true;
  enableCompletion = true;
  autosuggestion.enable = true;
  syntaxHighlighting.enable = true;

  shellAliases = {
    update = "sudo nixos-rebuild switch --flake ~/.mynixos#nixos";
    edit = "sudo nvim ~/.mynixos";
  };

  initContent = ''
    export EDITOR="nvim"
    export VISUAL="nvim"
    export PATH="$HOME/.opencode/bin:$PATH"

    autoload -U promptinit
    promptinit
    prompt pure
  '';
};

home.packages = with pkgs; [
  pure-prompt
];
```

### Pure Prompt

O tema `pure` não é um tema oh-my-zsh — é um prompt standalone que usa o sistema `promptinit` do zsh.

**Por que não oh-my-zsh?**
- `pure` (sindresorhus/pure) é um projeto separado
- Não está integrado ao oh-my-zsh
- Usa `promptinit` para carregar automaticamente

### Git (home/git.nix)

```nix
programs.git = {
  enable = true;
  userName = "Mauricio";
  userEmail = "...";
  extraConfig.init.defaultBranch = "main";
};
```

### Dev (home/dev.nix)

Neovim como editor padrão.

### Packages (home/packages.nix)

```nix
home.packages = with pkgs; [
  tree
  jq
  yq-go
  file
];
```

### Zen Browser (home/zen.nix)

Instalado via flake `zen-browser-flake`:

```nix
home.packages = [ inputs.zen-browser.packages.${pkgs.system}.default ];
```

### MangoWM (home/mango.nix)

Configuração completa do window manager. Veja [desktop.md](desktop.md) para detalhes.

### GTK (home/gtk.nix)

```nix
gtk = {
  iconTheme = {
    name = "Papirus-Dark";
    package = pkgs.papirus-icon-theme;
  };
};
```

## Backup Files

Quando o home-manager detecta conflitos, cria arquivos `.backup`:

```bash
# Listar backups
ls ~/.config/*.backup

# Remover backups após verificar
rm ~/.config/*.backup
```

## NixOS vs Home Manager

| Configuração | Onde fica |
|---|---|
| Shell do usuário | `home/shell.nix` |
| Shell padrão do sistema | `modules/users.nix` |
| Programas do usuário | `home/packages.nix` |
| Programas do sistema | `modules/dev-tools.nix` |
| Fonts | `modules/fonts.nix` |
| Icon theme | `home/gtk.nix` |
| Window manager | `home/mango.nix` |
| Display manager | `modules/desktop.nix` |
