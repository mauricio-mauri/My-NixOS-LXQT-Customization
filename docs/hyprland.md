# Hyprland como sessão Wayland do LXQt

O Openbox continua sendo a sessão padrão (X11). O Hyprland entra como uma
sessão Wayland separada, iniciada pela sessão **LXQt (Wayland)** do LightDM.
Com isso, os serviços do LXQt (painel, pcmanfm-qt, notificações, energia,
policykit) sobem dentro do Hyprland.

## Como funciona

1. `modules/hyprland.nix` instala o Hyprland (`programs.hyprland`).
2. Em `~/.config/lxqt/session.conf`, a chave `compositor=Hyprland` faz o
   script `startlxqtwayland` iniciar o Hyprland em vez do labwc (padrão).
3. O perfil `~/.config/lxqt/wayland/lxqt-hyprland.conf` é criado a partir do
   perfil padrão do LXQt na primeira execução. Ele inicia `lxqt-session`.

## GPUs

| Papel | GPU | Caminho estável |
|---|---|---|
| Primária (renderização) | AMD Radeon HD 6400M/7 (`0000:01:00.0`, driver `radeon`) | `/dev/dri/amd-gpu` |
| Fallback e scanout da tela | Intel HD 3000 (`0000:00:02.0`, driver `i915`) | `/dev/dri/intel-gpu` |

A variável `AQ_DRM_DEVICES` define a ordem: a primeira GPU renderiza e a
segunda entra se a primeira não estiver disponível. A tela do notebook é
alimentada pela Intel, por isso ela precisa estar na lista.

Os links `amd-gpu` e `intel-gpu` são criados por regras de udev, porque os
caminhos `/dev/dri/by-path` contêm `:` e o Hyprland não aceita esse caractere
dentro da lista.

Validação em `eglinfo` (Mesa 26.1.8): AMD `r600` expõe OpenGL ES 3.1 e Intel
`crocus` expõe OpenGL ES 3.0. O Hyprland exige GLES 3.0. A Intel fica no
mínimo, então qualquer falha de renderização deve ser investigada primeiro
na Intel.

## Para testar

1. Aplicar a configuração:
   ```sh
   cd ~/My-NixOS-LXQT-Customization
   sudo nixos-rebuild switch -I nixos-config="$PWD/configuration.nix"
   ```
2. Fazer logout. Na tela do LightDM, escolher **LXQt (Wayland)** no menu de
   sessões. O LightDM pode lembrar essa escolha no próximo login, então
   confira o menu antes de entrar.
3. Se a sessão não abrir, volte para o **Openbox** (ou LXQt X11) e consulte
   `journalctl -b -u display-manager` e o log do Hyprland em
   `/run/user/$UID/hyprland.log` ou `~/.cache/hyprland/`.

## Para reverter

- Sessão: remover a linha `compositor=Hyprland` de `~/.config/lxqt/session.conf`
  (volta para o labwc) ou simplesmente escolher o Openbox no login.
- Sistema: remover `../../modules/hyprland.nix` de `hosts/laptop/default.nix`
  e rodar o `switch`.

## O que ainda não foi feito

- **Atalhos:** os atalhos de `globalkeyshortcuts.conf` não funcionam no
  Wayland. Eles precisam ser refeitos em `lxqt-hyprland.conf` (`bind = ...`).
- **Aparência:** bordas e títulos passam a ser do Hyprland
  (`general:border_size`, `decoration`), e o Openbox não se aplica.
- **Layout de teclado:** o script ajusta `kb_layout` a partir de `session.conf`.
  A troca Super+Espaço ainda precisa de `kb_options = grp:win_space_toggle`.
- **Não testado:** nenhum desses itens foi validado numa sessão real. O
  `dry-build` passou, mas o comportamento só se confirma no login.
