# NixOS clássico com LXQt

Configuração modular para dois alvos: o laptop físico e uma VM de teste. Usa os módulos padrão do NixOS, o canal estável 26.05 e LXQt com LightDM. Não usa Flakes nem Home Manager.

## Arquitetura

```text
configuration.nix              # perfil padrão do laptop
configuration-vm.nix           # perfil alternativo da VM
hosts/
├── laptop/default.nix          # opções específicas do laptop
└── vm/default.nix              # opções específicas da VM
modules/                       # módulos NixOS reutilizados pelos dois hosts
dotfiles/                      # arquivos de usuário, copiados manualmente
```

Cada host também precisa de um `hardware-configuration.nix` gerado localmente. Esses arquivos são ignorados pelo Git porque contêm UUIDs de disco e outros detalhes da máquina. Não copie a configuração de hardware da VM para o laptop.

## Canal NixOS

Use o canal estável 26.05 nos dois hosts. Execute estes comandos **em um NixOS instalado**, não no Zorin:

```sh
sudo nix-channel --add https://nixos.org/channels/nixos-26.05 nixos
sudo nix-channel --update
```

Sem `flake.lock`, a versão do nixpkgs vem do canal configurado localmente. Atualize o canal deliberadamente e use Git para revisar as mudanças da configuração.

## Perfis e rebuild

Execute a partir da raiz deste repositório, depois de gerar o arquivo local de hardware do host correspondente:

```sh
# Laptop
sudo nixos-rebuild dry-build -I nixos-config="$PWD/configuration.nix"
sudo nixos-rebuild switch -I nixos-config="$PWD/configuration.nix"

# VM de teste
sudo nixos-rebuild dry-build -I nixos-config="$PWD/configuration-vm.nix"
sudo nixos-rebuild switch -I nixos-config="$PWD/configuration-vm.nix"
```

O perfil do laptop usa `system.stateVersion = "26.05"`; o da VM preserva `25.11`. Não altere `stateVersion` em instalações já existentes.

## Módulos de sistema

- `desktop.nix`: LXQt, LightDM, impressão e aplicativos gráficos.
- `dev-tools.nix`: Git, Neovim, ferramentas de desenvolvimento e OpenCode CLI.
- `nix-config.nix`: `nix-command`, suporte a binários não livres, `nix-ld`, coleta periódica de lixo e zram.
- Os demais módulos configuram boot, áudio, idioma, rede, usuário, fontes, Flatpak, Docker e SSH.

## OpenCode

O CLI é instalado como pacote de sistema por `modules/dev-tools.nix`:

```sh
opencode --version
```

Preferências e credenciais do OpenCode não são armazenadas neste repositório. Configure a conta no perfil do usuário após a instalação.

## Dotfiles

Não há ativação automática de dotfiles. Copie apenas o que quiser usar:

```sh
mkdir -p ~/.config/alacritty ~/.config/git
cp dotfiles/alacritty/alacritty.toml ~/.config/alacritty/alacritty.toml
cp dotfiles/git/config ~/.config/git/config
cp dotfiles/zsh/.zshrc ~/.zshrc
```

Defina seu e-mail do Git localmente em `~/.config/git/config`. A escolha do tema de ícones Papirus pode ser feita nas configurações do LXQt.

## Instalação física

O repositório descreve a configuração do NixOS; não formata discos nem instala o sistema. Antes da instalação, faça backup e gere o arquivo de hardware no laptop. A instalação e o particionamento ficam a cargo do usuário.
