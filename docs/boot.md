# Boot — GRUB + Plymouth

## Visão Geral

O processo de boot cobre três estágios:

```
┌──────────────┐     ┌──────────────┐     ┌──────────────┐
│  GRUB        │────▶│  Kernel      │────▶│  Plymouth    │
│  (bootloader)│     │  + initrd    │     │  (splash)    │
│  hidden      │     │              │     │  bgrt theme  │
│  Shift=show  │     │              │     │              │
└──────────────┘     └──────────────┘     └──────────────┘
         │                                       │
         ▼                                       ▼
    Shift/ESC/F4                           Até SDDM
    mostra menu
```

## GRUB

### Configuração (modules/boot.nix)

```nix
boot.loader.grub = {
  enable = true;
  device = "/dev/sda";
  useOSProber = false;
  timeoutStyle = "hidden";
};

boot.loader.timeout = 0;
```

### Comportamento Hidden

- **Padrão**: Menu escondido, boot automático
- **Shift held**: Mostra menu do GRUB
- **ESC/F4**: Alternativa ao Shift

### Por que `timeout = 0`?

Com `timeoutStyle = "hidden"` e `timeout = 0`:
- GRUB faz boot imediatamente
- Ainda verifica teclas durante a inicialização
- Shift durante POST/GRUB mostra o menu
- Funciona de forma confiável em sistemas BIOS

### Alternativas

```nix
# Opção mais confiável (1s de janela)
boot.loader.timeout = 1;

# Menu sempre visível
boot.loader.grub.timeoutStyle = "menu";
boot.loader.timeout = 5;
```

## Plymouth

### Configuração

```nix
boot.plymouth = {
  enable = true;
  theme = "bgrt";
};
```

### Tema `bgrt`

- **BGRT** = Boot Graphics Resource Table
- Mostra logo do OEM (ou NixOS) durante boot
- Animação de loading minimalista
- É o tema padrão do Plymouth

### Silent Boot

Para esconder mensagens de terminal durante boot:

```nix
boot.consoleLogLevel = 3;
boot.initrd.verbose = false;
boot.kernelParams = [
  "quiet"
  "rd.udev.log_level=3"
  "rd.systemd.show_status=auto"
];
```

| Parâmetro | Efeito |
|---|---|
| `consoleLogLevel = 3` | Esconde mensagens warning/info |
| `initrd.verbose = false` | Esconde output do initrd |
| `quiet` | Kernel silencioso |
| `rd.udev.log_level=3` | Udev sem info |
| `rd.systemd.show_status=auto` | Systemd auto-hide |

### Themes Disponíveis

Built-in themes do Plymouth:
- `bgrt` — Logo OEM + spinner (padrão)
- `spinner` — Apenas spinner
- `fade-in` — Fade in/out com estrelas
- `solar` — Tema espacial
- `text` — Modo texto com barra

Themes de terceiros (nixpkgs):
- `adi1090x-plymouth-themes` — 80+ themes (rings, angular, etc.)

### During Boot

- **Escape**: Alterna entre Plymouth e modo texto
- **Esc**: Interrompe Plymouth (se configurado)

## Kernel

```nix
boot.kernelPackages = pkgs.linuxPackages_latest;
```

Usa a última versão estável do kernel Linux.

## Interação com SDDM

Plymouth roda até o SDDM aparecer. A transição é automática:

```
GRUB → Kernel → Plymouth (splash) → SDDM (login) → MangoWM
```
