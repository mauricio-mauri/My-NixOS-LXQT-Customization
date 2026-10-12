# Desktop LXQt

O desktop é LXQt sobre X11, com LightDM. Ele usa as opções nativas do NixOS e não depende de MangoWM, DMS, QuickShell, Flakes ou Home Manager.

O módulo `modules/desktop.nix` habilita LXQt, LightDM, gráficos, impressão e instala Alacritty, Foot, Dolphin e o tema de ícones Papirus. LXQt também fornece seus próprios componentes básicos, incluindo o gerenciador de arquivos PCManFM-Qt.

## Teclado e aparência

O layout de teclado inicial é `us,br`; preferências como alternância de layout e tema de ícones podem ser ajustadas no LXQt Configuration Center. Papirus-Dark é instalado, mas a seleção do tema é feita na sessão do usuário.

## Configuração do Alacritty

O TOML em `dotfiles/alacritty/alacritty.toml` preserva as cores Catppuccin, a fonte JetBrainsMono Nerd Font e os atalhos anteriores. Como não há Home Manager, copie o arquivo manualmente para `~/.config/alacritty/alacritty.toml`.
