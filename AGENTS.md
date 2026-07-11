# AGENTS.md

Personal NixOS system configuration for user `mauri` (Mauricio).

## Repository structure

- `flake.nix` — Flake entry point (nixpkgs 25.11 + home-manager + DMS + MangoWM + quickshell)
- `hosts/nixos/` — Host-specific config
  - `default.nix` — Imports all modules
  - `hardware-configuration.nix` — Auto-generated, do not edit manually
- `modules/` — System-level NixOS modules
- `home/` — Home-manager configuration (user: mauri)

## Key system facts

- **Locale**: `pt_BR.UTF-8`, timezone `America/Belem`
- **Desktop**: MangoWM + Dank Material Shell on Wayland, SDDM (Wayland mode, Catppuccin Mocha Mauve theme)
- **Boot**: GRUB on `/dev/sda` (BIOS system, no os-prober, hidden by default — Shift to show)
- **Plymouth**: Enabled with bgrt theme + silent boot
- **Shell**: Zsh (default), oh-my-zsh with pure theme
- **Kernel**: `linuxPackages_latest`
- **Platform**: x86_64-linux
- **stateVersion**: `25.11`
- **Notable settings**: `nix-ld` enabled, `allowUnfree` enabled, flakes enabled
- **SSH**: OpenSSH enabled, password auth disabled
- **Flake inputs**: nixpkgs, home-manager, mangowm, dms, dgop, zen-browser, quickshell (upstream for 0.3.0+)
- **Nerd-fonts**: JetBrains Mono, Fira Code
- **Icon theme**: Papirus-Dark
- **Keyboard**: us,br — Super+Shift+Space to switch (MangoWM native)

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

## Important notes

- **Do NOT** run `sudo nixos-rebuild switch` without `--flake` — old `/etc/nixos/configuration.nix` still exists with Cinnamon/LightDM
- DMS requires quickshell ≥0.3.0 (upstream flake), not from nixpkgs 25.11 (0.2.1)
- DMS options removed in v1.5: `enableBrightnessControl`, `enableClipboard`, `enableColorPicker`, `enableSystemSound` — now built-in
- DMS NixOS module uses `systemd.enable = false` — exec-once in Mango config instead
- MangoWM HM module: `inputs.mangowm.hmModules.mango` (not `homeModules.mango`)
- `input` group required for DMS evdev manager
- `enableSystemMonitoring` defaults to `true` when `enable = true` — setting explicitly is a no-op
- MangoWM keyboard layouts: `xkb_rules_layout` / `xkb_rules_variant` (not `services.xserver.xkb`)
- MangoWM `switch_keyboard_layout` — NOT the same as `switch_layout` (window layouts)
- GRUB hidden: `timeoutStyle = "hidden"` + `timeout = 0` — Shift/ESC/F4 to show menu
- Plymouth silent boot: `consoleLogLevel = 3`, `initrd.verbose = false`, `quiet` kernel param
