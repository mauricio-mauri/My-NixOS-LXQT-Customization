# Configuração clássica e instalação

## Antes de instalar

1. Fazer backup dos dados do Zorin e guardar uma cópia do repositório fora do disco interno.
2. Inicializar o live USB e confirmar o modo BIOS/UEFI e o dispositivo de instalação.
3. Gerar o arquivo de hardware **no host correspondente**. O arquivo da VM não serve para o laptop.
4. Testar `configuration-vm.nix` em NixOS 26.05 antes de usar `configuration.nix` no laptop.

Este repositório não particiona nem formata o disco. A instalação física é feita separadamente pelo usuário após o backup.

## Canal sem Flakes

No NixOS instalado, configurar o canal estável 26.05 e executar `nix-channel --update`. A configuração NixOS continua modular via `imports`, mas não contém `inputs`, `outputs` ou `flake.lock`. Para atualização, faça primeiro `dry-build` e depois `switch`.

## Arquivos de hardware

O arquivo `hardware-configuration.nix` é gerado localmente e ignorado pelo Git. Para o perfil da VM, preserve a cópia local em `hosts/vm/`; para o laptop, gere outra em `hosts/laptop/`. Nunca commite esses arquivos.

## Perfis

```sh
# Da raiz do repositório, em um NixOS instalado:
sudo nixos-rebuild dry-build -I nixos-config="$PWD/configuration-vm.nix"
sudo nixos-rebuild switch -I nixos-config="$PWD/configuration-vm.nix"

sudo nixos-rebuild dry-build -I nixos-config="$PWD/configuration.nix"
sudo nixos-rebuild switch -I nixos-config="$PWD/configuration.nix"
```

O segundo par aplica o perfil do laptop; use-o apenas quando o hardware e o bootloader estiverem configurados para essa máquina.
