# Migração do Monolítico

## Situação Inicial

O sistema original usava um arquivo monolítico `/etc/nixos/configuration.nix` com:

- Desktop Cinnamon (X11)
- LightDM (display manager)
- Configuração não modular
- Sem home-manager
- Sem flakes

## Problema

Arquivo monolítico único tornava difícil:
- Versionar configurações
- Reutilizar módulos
- Manter configurações específicas do host
- Gerenciar configurações de usuário separadamente

## Solução: Flake Modular

### 1. Criar Flake Base

```nix
# flake.nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    home-manager.url = "github:nix-community/home-manager/release-25.11";
  };
  outputs = { self, nixpkgs, home-manager, ... }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./hosts/nixos
        home-manager.nixosModules.home-manager
      ];
    };
  };
}
```

### 2. Extrair Módulos do Monolítico

O arquivo `configuration.nix` original foi decomposto em módulos:

| Monolítico | Modular |
|---|---|
| `boot.loader.grub.*` | `modules/boot.nix` |
| `services.xserver.desktopManager.cinnamon.*` | `modules/desktop.nix` |
| `i18n.defaultLocale` | `modules/locale.nix` |
| `networking.networkmanager.*` | `modules/networking.nix` |
| `services.pipewire.*` | `modules/audio.nix` |
| `services.openssh.*` | `modules/ssh.nix` |
| `users.users.mauri.*` | `modules/users.nix` |
| `nix.settings.*` | `modules/nix-config.nix` |

### 3. Adicionar Home Manager

Home Manager permite gerenciar configurações de usuário de forma declarativa:

```nix
home-manager.nixosModules.home-manager
{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.mauri = {
      imports = [ ./home ];
    };
  };
}
```

### 4. Migrar Desktop

A migração do desktop incluiu:

1. **Cinnamon → MangoWM**: Window manager tiling para Wayland
2. **LightDM → SDDM**: Display manager moderno com suporte Wayland
3. **X11 → Wayland**: Protocolo gráfico moderno
4. **Adicionar DMS**: Dank Material Shell para interface material

### 5. Configurar Flake Lock

O `flake.lock` bloqueia versões específicas de cada input:

```bash
nix flake update                    # Atualizar todos
nix flake update quickshell         # Atualizar um específico
```

## Commits da Migração

```
83e1b2a Initial flake + home-manager setup
bb4b038 Fix deprecation warnings and update AGENTS.md
08d5c99 Remove stale root config files
40e7453 Add legacy config files to .gitignore
```

## Arquivo Antigo (não usar!)

O `/etc/nixos/configuration.nix` antigo ainda existe com Cinnamon/LightDM. **NÃO** execute:

```bash
# ERRADO — usa config antiga
sudo nixos-rebuild switch

# CORRETO — usa flake
sudo nixos-rebuild switch --flake .#nixos
```
