# Desktop — MangoWM + DMS + Wayland

## Visão Geral

O desktop é composto por três camadas:

```
┌─────────────────────────────────────┐
│  DMS (Dank Material Shell)          │
│  ├── Spotlight                      │
│  ├── Clipboard                     │
│  ├── Process Manager               │
│  ├── Notifications                  │
│  ├── Settings                       │
│  └── Audio/Brightness              │
├─────────────────────────────────────┤
│  MangoWM (Window Manager)          │
│  ├── Keybinds                       │
│  ├── Layouts (tile, scroller)       │
│  ├── Window rules                   │
│  └── Animations                     │
├─────────────────────────────────────┤
│  Wayland (wlroots compositor)      │
│  ├── SDDM (login)                  │
│  └── Alacritty (terminal)          │
└─────────────────────────────────────┘
```

## MangoWM

### Configuração (home/mango.nix)

O MangoWM é configurado via home-manager usando o módulo `inputs.mangowm.hmModules.mango`.

**Nota**: O módulo é `hmModules.mango`, NÃO `homeModules.mango`.

### Keybinds

| Atalho | Comando | Descrição |
|---|---|---|
| `Super+Return` | `alacritty` | Abrir terminal |
| `Super+Space` | `dms ipc call spotlight toggle` | DMS Spotlight |
| `Super+Shift+Space` | `switch_keyboard_layout` | Trocar us/br |
| `Super+F1` | `alacritty -e show-keybinds.sh` | Ajuda de keybinds |
| `Alt+Q` | `killclient` | Fechar janela |
| `Alt+F` | `togglefullscreen` | Tela cheia |
| `Alt+Backslash` | `togglefloating` | Alternar floating |
| `Super+Tab` | `focusstack,next` | Próxima janela |
| `Alt+1-9` | `tag,1-9` | Mover para tag |
| `Ctrl+1-9` | `view,1-9` | Ver tag |

### Aparência

```nix
border_radius = 12;
borderpx = 2;
focused_opacity = 1.0;
unfocused_opacity = 0.9;
gappih = 5;  # gap interno horizontal
gappiv = 5;  # gap interno vertical
gappoh = 5;  # gap externo horizontal
gappov = 5;  # gap externo vertical
```

### Animações

```nix
animations = 1;
layer_animations = 1;
animation_type_open = "slide";
animation_type_close = "slide";
animation_duration_move = 500;
animation_duration_open = 400;
animation_duration_tag = 350;
animation_duration_close = 800;
```

### Keyboard Layouts

As configurações de layout são gerenciadas pelo MangoWM (não por `services.xserver.xkb`):

```nix
xkb_rules_layout = "us,br";
xkb_rules_variant = ",";
```

**Importante**: `switch_keyboard_layout` é diferente de `switch_layout`:
- `switch_keyboard_layout` — troca entre layouts de teclado (us/br)
- `switch_layout` — troca entre layouts de janela (tile/scroller)

### Source Includes

O MangoWM inclui arquivos de configuração do DMS:

```nix
source = [
  "~/.config/mango/dms/colors.conf"
  "~/.config/mango/dms/layout.conf"
  "~/.config/mango/dms/outputs.conf"
];
```

### Autostart

```nix
"exec-once" = [
  "dms run"                                    # DMS shell
  "wl-paste --type text --watch cliphist store"  # Clipboard
  "dbus-update-activation-environment --systemd --all"
  "systemctl --user start mango-session.target"
];
```

## Dank Material Shell (DMS)

### Integração

DMS roda como um processo separado via `exec-once=dms run`. O módulo NixOS `dank-material-shell` fornece:

- Pacotes de sistema (dms, quickshell)
- Configuração de dgop (system monitoring)
- Regras de janela para DMS

### Configuração NixOS (modules/desktop.nix)

```nix
programs.dank-material-shell = {
  enable = true;
  quickshell.package = inputs.quickshell.packages.${pkgs.system}.quickshell;
  dgop.package = inputs.dgop.packages.${pkgs.system}.default;
};
```

### Requisitos

- quickshell ≥0.3.0 (upstream flake, não nixpkgs)
- dgop (system monitoring backend)
- `input` group no usuário para evdev manager

### IPC Commands

DMS expõe comandos via IPC para controle remoto:

```bash
dms ipc call spotlight toggle
dms ipc call clipboard toggle
dms ipc call processlist focusOrToggle
dms ipc call settings focusOrToggle
dms ipc call notifications toggle
dms ipc call dankdash wallpaper
dms ipc call lock lock
dms ipc call audio increment 3
dms ipc call brightness increment 5
```

## SDDM

### Tema

Catppuccin Mocha Mauve:

```nix
services.displayManager.sddm = {
  enable = true;
  wayland.enable = true;
  theme = "${pkgs.catppuccin-sddm}/share/sddm/themes/catppuccin-mocha-mauve";
};
```

### Modo Wayland

SDDM roda em modo Wayland para consistência com o desktop.

## Terminal

Alacritty é o terminal principal, instalado como pacote de sistema:

```nix
environment.systemPackages = with pkgs; [
  alacritty
  foot  # fallback
];
```

## Icon Theme

Papirus-Dark configurado via home-manager GTK:

```nix
gtk = {
  iconTheme = {
    name = "Papirus-Dark";
    package = pkgs.papirus-icon-theme;
  };
};
```
