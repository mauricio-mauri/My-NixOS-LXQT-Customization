# mynixos

Configuração NixOS para o usuário `mauri` (Mauricio). Sistema declarativo completo usando flakes, home-manager e módulos modulares.

## Resumo do Sistema

| Componente | Tecnologia |
|---|---|
| **OS** | NixOS 25.11 (Xantusia) |
| **Desktop** | MangoWM + Dank Material Shell (Wayland) |
| **Login** | SDDM (Catppuccin Mocha Mauve) |
| **Boot** | GRUB (hidden) + Plymouth (bgrt theme) |
| **Shell** | Zsh + pure-prompt |
| **Plataforma** | x86_64-linux, BIOS (Insyde firmware) |

## Estrutura do Repositório

```
~/.mynixos/
├── flake.nix                    # Entry point do flake
├── flake.lock                   # Inputs bloqueados
├── hosts/nixos/
│   ├── default.nix              # Importa todos os módulos
│   └── hardware-configuration.nix  # Auto-gerado (não editar)
├── modules/                     # Módulos NixOS (sistema)
│   ├── boot.nix                 # GRUB, Plymouth, kernel
│   ├── desktop.nix              # MangoWM, DMS, SDDM, Papirus
│   ├── fonts.nix                # Nerd-fonts
│   ├── dev-tools.nix            # git, neovim, gcc, fastfetch
│   ├── users.nix                # Usuário mauri
│   ├── audio.nix                # PipeWire
│   ├── networking.nix           # NetworkManager
│   ├── ssh.nix                  # OpenSSH
│   ├── docker.nix               # Docker
│   ├── flatpak.nix              # Flatpak + Flathub
│   ├── nix-config.nix           # Flakes, allowUnfree, nix-ld
│   └── locale.nix               # pt_BR.UTF-8, America/Belem
└── home/                        # Home-manager (usuário)
    ├── default.nix              # Importa todos os módulos home
    ├── shell.nix                # Zsh, pure-prompt, aliases
    ├── git.nix                  # Git config
    ├── dev.nix                  # Neovim
    ├── packages.nix             # tree, jq, yq-go, file
    ├── zen.nix                  # Zen Browser
    ├── mango.nix                # MangoWM config completa
    ├── gtk.nix                  # Papirus-Dark icon theme
    └── show-keybinds.sh         # Script de ajuda (SUPER+F1)
```

## Como Aplicar Mudanças

```bash
# Rebuild do sistema
sudo nixos-rebuild switch --flake .#nixos

# Ou usando o alias (após rebuild com zsh)
update

# Editar config
edit

# Validar flake sem aplicar
nix flake check
```

## Flake Inputs

| Input | Fonte | Finalidade |
|---|---|---|
| `nixpkgs` | `github:NixOS/nixpkgs/nixos-25.11` | Pacotes base |
| `home-manager` | `github:nix-community/home-manager/release-25.11` | Config do usuário |
| `mangowm` | `github:mangowm/mango` | Window manager |
| `dms` | `github:AvengeMedia/DankMaterialShell/stable` | Shell material |
| `dgop` | `github:AvengeMedia/dgop` | DMS system monitoring |
| `quickshell` | `github:quickshell-mirror/quickshell` | QML runtime (≥0.3.0) |
| `zen-browser` | `github:youwen5/zen-browser-flake` | Zen Browser |

## Keybinds Principais

| Atalho | Ação |
|---|---|
| `Alt+Return` | Terminal (Alacritty) |
| `Super+Space` | DMS Spotlight |
| `Super+Shift+Space` | Trocar layout teclado (us/br) |
| `Super+F1` | Popup de keybinds |
| `Super+V` | Clipboard |
| `Super+N` | Notifications |
| `Super+M` | Process List |
| `Alt+Q` | Kill client |
| `Alt+F` | Toggle fullscreen |
| `Alt+Backslash` | Toggle floating |

Veja a lista completa em `home/show-keybinds.sh` ou pressione `Super+F1`.

## Documentação

Consulte o diretório `docs/` para documentação detalhada:

- [docs/arquitetura.md](docs/arquitetura.md) — Arquitetura do sistema
- [docs/migracao.md](docs/migracao.md) — Processo de migração do monolítico
- [docs/desktop.md](docs/desktop.md) — MangoWM + DMS + Wayland
- [docs/boot.md](docs/boot.md) — GRUB + Plymouth
- [docs/home-manager.md](docs/home-manager.md) — Configuração do usuário
- [docs/troubleshooting.md](docs/troubleshooting.md) — Problemas conhecidos

## Notas Importantes

- **NÃO** execute `sudo nixos-rebuild switch` sem `--flake` — o `/etc/nixos/configuration.nix` antigo ainda existe com Cinnamon/LightDM
- DMS requer quickshell ≥0.3.0 (upstream flake), não o da nixpkgs 25.11 (0.2.1)
- MangoWM usa `switch_keyboard_layout`, NÃO `switch_layout` (que muda layout de janelas)
- GRUB hidden: `timeoutStyle = "hidden"` + `timeout = 0` — Shift/ESC/F4 para mostrar menu
- Plymouth cobre desde o initrd até o SDDM
