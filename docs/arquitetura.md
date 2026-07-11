# Arquitetura do Sistema

## Visão Geral

O sistema é construído sobre um **flake NixOS** que orquestra configurações em três camadas:

```
┌─────────────────────────────────────────────┐
│  flake.nix (entry point)                     │
│  ├── nixpkgs 25.11                           │
│  ├── home-manager (config do usuário)        │
│  ├── MangoWM (window manager)                │
│  ├── DMS (Dank Material Shell)               │
│  ├── quickshell (QML runtime)                │
│  └── dgop (system monitoring)                │
├─────────────────────────────────────────────┤
│  hosts/nixos/default.nix                     │
│  └── Importa todos os módulos                │
├─────────────────────────────────────────────┤
│  modules/ (NixOS system-level)               │
│  ├── boot.nix       ├── desktop.nix          │
│  ├── fonts.nix      ├── dev-tools.nix        │
│  ├── users.nix      ├── audio.nix            │
│  ├── networking.nix ├── ssh.nix              │
│  ├── docker.nix     ├── flatpak.nix          │
│  ├── nix-config.nix └── locale.nix           │
├─────────────────────────────────────────────┤
│  home/ (home-manager user-level)             │
│  ├── shell.nix  ├── git.nix                  │
│  ├── dev.nix    ├── packages.nix             │
│  ├── zen.nix    ├── mango.nix                │
│  ├── gtk.nix    └── show-keybinds.sh         │
└─────────────────────────────────────────────┘
```

## Camada 1: NixOS System (modules/)

Responsável pela configuração de baixo nível do sistema operacional:

- **Boot**: GRUB + Plymouth + kernel
- **Desktop**: SDDM, MangoWM (via NixOS module), DMS, Papirus icons
- **Fonts**: Nerd-fonts (JetBrains Mono, Fira Code)
- **Serviços**: PipeWire (áudio), OpenSSH, Docker, Flatpak
- **Rede**: NetworkManager
- **Usuário**: mauri com grupos wheel, networkmanager, docker, input
- **Nix**: Flakes habilitado, allowUnfree, nix-ld

## Camada 2: Home Manager (home/)

Gerencia o ambiente do usuário `mauri`:

- **Shell**: Zsh + pure-prompt + autosuggestion + syntax highlighting
- **Git**: Configuração pessoal
- **Editor**: Neovim
- **Apps**: Zen Browser, alacritty, foot
- **MangoWM**: Config completa com keybinds, regras, aparência
- **GTK**: Icon theme Papirus-Dark

## Camada 3: DMS (Dank Material Shell)

Rodando sobre MangoWM via `exec-once=dms run`:

- Spotlight (Super+Space)
- Clipboard (Super+V)
- Process Manager (Super+M)
- Notifications (Super+N)
- Settings (Super+,)
- Wallpaper (Super+Y)
- Lock Screen (Super+Alt+L)
- Audio/Brightness controls (media keys)

## Fluxo de Build

```
nix flake check
       ↓
nixos-rebuild switch --flake .#nixos
       ↓
┌──────────────┐    ┌──────────────┐
│  NixOS Gen   │    │ Home Manager │
│  (system)    │───▶│  (user)      │
│  - boot      │    │  - shell     │
│  - desktop   │    │  - mango     │
│  - fonts     │    │  - git       │
│  - services  │    │  - gtk       │
└──────────────┘    └──────────────┘
```

## Gerações

NixOS mantém um histórico de configurações (gerações). Cada rebuild cria uma nova geração:

```bash
# Listar gerações
nixos-rebuild list-generations

# Rollback para geração anterior
sudo nixos-rebuild switch --rollback
```

Home Manager também mantém suas próprias gerações, ativadas automaticamente após o rebuild do sistema.
