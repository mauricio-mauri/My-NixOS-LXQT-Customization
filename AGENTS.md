# Instruções do repositório

Configuração modular NixOS para o laptop `mauri` e uma VM de teste.

## Princípios

- Usar módulos NixOS locais com `imports`; não usar Flakes nem Home Manager.
- O canal esperado é NixOS 26.05. A VM conserva `system.stateVersion = "25.11"`; o perfil novo do laptop usa `"26.05"`.
- `configuration.nix` seleciona o laptop; `configuration-vm.nix` seleciona a VM.
- Configuração comum fica em `modules/`; opções específicas de máquina ficam em `hosts/`.
- `hardware-configuration.nix` é gerado por host, fica local e não deve ser adicionado ao Git.
- Dotfiles em `dotfiles/` são arquivos comuns e não são ativados automaticamente.
- OpenCode CLI é instalado em `modules/dev-tools.nix` como `pkgs.opencode`; não adicionar credenciais ao repositório.

## Aplicar e validar

Executar a partir da raiz do repositório em um NixOS instalado:

```sh
sudo nixos-rebuild dry-build -I nixos-config="$PWD/configuration.nix"
sudo nixos-rebuild switch -I nixos-config="$PWD/configuration.nix"
```

Para a VM, usar `configuration-vm.nix`. Validar os arquivos `.nix` e testar o perfil da VM antes do laptop sempre que possível.

Este repositório contém apenas configurações. Não particionar, formatar nem alterar o Zorin durante mudanças neste projeto.
