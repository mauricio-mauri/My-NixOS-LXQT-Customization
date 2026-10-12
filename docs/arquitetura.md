# Arquitetura

## Dois perfis, módulos compartilhados

O sistema usa o mecanismo clássico de módulos NixOS. `configuration.nix` e `configuration-vm.nix` são pontos de entrada distintos; ambos importam os módulos comuns e o hardware local correspondente.

```text
configuration.nix ────────┐
                          ├── hosts/<alvo>/default.nix
configuration-vm.nix ────┘        ├── hardware-configuration.nix (local)
                                   └── ../../modules/*.nix
```

O perfil do laptop é o padrão. A configuração da VM permite testar o mesmo desktop e os mesmos pacotes sem atrelar a configuração comum a UUIDs, partições ou ao bootloader de um só computador.

## Módulos

- `boot.nix`: GRUB com menu visível e Plymouth.
- `desktop.nix`: X11, LXQt, LightDM, impressão e aplicativos gráficos.
- `locale.nix`, `networking.nix`, `audio.nix`, `users.nix`: idioma, rede, áudio e usuário.
- `dev-tools.nix`: ferramentas, Neovim e OpenCode.
- `nix-config.nix`: opções do Nix, garbage collection e zram.
- `fonts.nix`, `flatpak.nix`, `docker.nix`, `ssh.nix`: serviços opcionais/complementares.

Os módulos compartilhados continuam declarativos. Os arquivos em `dotfiles/` são configurações normais do usuário que podem ser copiados manualmente.

## Hardware e privacidade

Cada host gera seu próprio `hardware-configuration.nix`. Ele é ignorado pelo Git: pode conter UUIDs de sistemas de arquivos, configuração de swap e detalhes de dispositivos. Não o substitua por um arquivo de outro host.

## Versões

Sem `flake.lock`, a revisão do nixpkgs vem do canal local. Ambos os hosts devem acompanhar o canal estável 26.05. `system.stateVersion` é uma opção por instalação, não um seletor do canal; não deve ser alterado após a instalação.
