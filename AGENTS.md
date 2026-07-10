# AGENTS.md

Personal NixOS system configuration for user `mauri` (Mauricio).

## Repository structure

- `flake.nix` — Flake entry point (nixpkgs 25.11 + home-manager)
- `hosts/nixos/` — Host-specific config
  - `default.nix` — Imports all modules
  - `hardware-configuration.nix` — Auto-generated, do not edit manually
- `modules/` — System-level NixOS modules
- `home/` — Home-manager configuration (user: mauri)

## Key system facts

- **Locale**: `pt_BR.UTF-8`, timezone `America/Belem`
- **Desktop**: Cinnamon on X11 with LightDM
- **Boot**: GRUB on `/dev/sda` (BIOS system, no os-prober)
- **Kernel**: `linuxPackages_latest`
- **Platform**: x86_64-linux
- **stateVersion**: `25.11`
- **Notable settings**: `nix-ld` enabled, `allowUnfree` enabled, flakes enabled
- **SSH**: OpenSSH enabled, password auth disabled

## Applying changes

From `~/.mynixos`:

```sh
sudo nixos-rebuild switch --flake .#nixos
```

Validate flake without applying:

```sh
nix flake check
```

## Home Manager

Runs as a NixOS module (not standalone). User config lives in `home/`.

After system rebuild, home-manager activates automatically. If home-manager backup files are created, they end up as `.backup` files in the home directory.
