# Customização do LXQt

O LXQt não tem módulo declarativo nem no NixOS nem no Home Manager. A
customização acontece inteiramente por arquivos `~/.config/lxqt/*.conf`, no
formato INI. Este documento descreve o que dá para customizar em cada um.

## Como o LXQt é versionado neste repositório

Os arquivos ficam em `dotfiles/lxqt/`. A ativação em `modules/home.nix` os
**copia** para a Home — não cria link. Motivo: o LXQt reescreve esses arquivos
quando você muda algo pela interface. Se fossem links somente leitura para o
store, a interface não conseguiria gravar.

A cópia só acontece se o arquivo ainda não existir na Home, então mudanças
feitas pela GUI sobrevivem ao `switch`. Para sincronizar nos dois sentidos:

- `lxqt-save` — copia da Home para o repositório (salva o que você mudou na GUI)
- `lxqt-apply` — copia do repositório para a Home (restaura o que está versionado)

Os dois ficam definidos em `dotfiles/zsh/.zshrc`.

## Arquivos fora do versionamento

| Arquivo | Motivo |
|---|---|
| `panel.conf` | Contém caminhos do `/nix/store` (ex.: `apps\1\desktop=/nix/store/.../firefox.desktop`), que mudam a cada rebuild, e um UUID gerado pelo painel. Versioná-lo guarda valores que já estão obsoletos. |
| `lxqt-config-monitor.conf` | Guarda geometria de monitores e as configurações salvas. É estado da máquina, não intenção. |

As regras de exclusão também estão nos aliases `lxqt-save`/`lxqt-apply`.

---

## lxqt.conf

Aparência geral do desktop. O arquivo mais visível.

### `[General]`

| Chave | O que faz | Valor atual |
|---|---|---|
| `theme` | Nome do tema Qt. Precisa estar instalado no sistema. | `Valendas` |
| `icon_theme` | Nome do tema de ícones. `papirus-icon-theme` está em `modules/desktop.nix`. | `Papirus-Dark` |
| `icon_follow_color_scheme` | `true` faz os ícones seguirem o esquema claro/escuro. | `true` |
| `tool_bar_icon_size` | Tamanho dos ícones nas barras de ferramentas. | `24` |
| `wallpaper_override` | `true` faz o LXQt ignorar o papel de parede definido no pcmanfm-qt. | `false` |

Os temas disponíveis nesta instalação (do pacote `lxqt-themes`, que vem com o
desktop): `ambiance`, `Arch-Colors`, `Clearlooks`, `dark`, `frost`,
`graphite`, `KDE-Plasma`, `kvantum`, `Leech`, `light`, `silver`, `system`,
`Valendas`. Para usar outro tema de terceiros, instale o pacote que o fornece
e coloque o nome em `theme`.

Para mudar tema, fonte ou ícones pela interface: Menu → Preferências →
Aparência do LXQt. Depois rode `lxqt-save` para versionar a mudança.

### `[Palette]`

Cores do esquema Qt usado pelos aplicativos: `base_color`, `text_color`,
`highlight_color`, `highlighted_text_color`, `window_color`,
`window_text_color`, `tooltip_base_color`, `tooltip_text_color`, `link_color`,
`link_visited_color`. Edite em hexadecimal (`#rrggbb`). Isso só vale quando o
tema usa a paleta do sistema.

### `[Qt]`

| Chave | O que faz | Valor atual |
|---|---|---|
| `font` | Fonte global do Qt, no formato Qt: `Família,Tamanho,...,peso,etc`. Mude só a família e o número após a primeira vírgula para não quebrar os campos restantes. | `FiraCode Nerd Font Ret,12,...` |

---

## session.conf

Sessão, janela, teclado e variáveis de ambiente.

### `[General]`

| Chave | O que faz | Valor atual |
|---|---|---|
| `window_manager` | Qual window manager iniciar. Deve estar instalado: `openbox`, `marco`, `kwin_x11`, `i3`, `bspwm`, etc. | `openbox` |

### `[Environment]`

Variáveis de ambiente exportadas para toda a sessão. Uma por linha,
no formato `NOME=valor`. As atuais:

- `GTK_CSD=0` — desliga o decorador de janela em aplicativos GTK
- `GTK_OVERLAY_SCROLLING=0` — desliga a barra de rolagem sobreposta do GTK

Para adicionar outra, crie uma linha nova aqui.

### `[Keyboard]`

Configuração XKB do teclado.

| Chave | O que faz | Valor atual |
|---|---|---|
| `layout` | Layouts, separados por vírgula. | `us,br` |
| `variant` | Variante de cada layout. | `,` |
| `model` | Modelo físico do teclado. | `pc104` |
| `options` | Opções XKB, separadas por vírgula. | `terminate:ctrl_alt_bksp, grp:win_space_toggle` |

`grp:win_space_toggle` é o atalho que alterna entre US e BR (Super+Espaço).
As opções XKB são documentadas em `xkeyboard-config`.

### `[Touchpad]`

Configurações por dispositivo. As chaves são nomes de dispositivo
URL-encodificados (o `%2520` é um espaço). Os valores são:

- `-1` = padrão
- `0` = desligado
- `1` = ligado

Chaves disponíveis por dispositivo: `accelSpeed`, `naturalScrollingEnabled`,
`tappingEnabled`, `tapToDragEnabled`, `dragLockEnabled`,
`disableWhileTypingEnabled`, `scrollingMethodEnabled`.

Atenção: os nomes de dispositivo são específicos desta máquina. Uma cópia em
outra máquina não terá efeito nenhum, mas não quebra nada.

---

## globalkeyshortcuts.conf

Atalhos globais de teclado. Cada atalho é uma seção nomeada
`[Tecla.N]`, onde `N` é um número sequencial.

### `[General]`

| Chave | O que faz | Valor atual |
|---|---|---|
| `AllowGrabBaseKeypad` | Permite capturar o teclado numérico base. | `true` |
| `AllowGrabBaseSpecial` | Permite capturar teclas especiais base. | `false` |
| `AllowGrabLocks` | Permite capturar Caps/Num/Scroll Lock. | `false` |
| `AllowGrabMiscKeypad` | Permite capturar o resto do teclado numérico. | `true` |
| `AllowGrabMiscSpecial` | Permite capturar o resto das especiais. | `true` |
| `MultipleActionsBehaviour` | O que fazer se o mesmo atalho tem vários atalhos: `first` ou `all`. | `first` |

### Cada atalho

| Chave | O que faz |
|---|---|
| `Comment` | Nome exibido na interface de configuração. |
| `Enabled` | `true`/`false` para ativar ou desativar o atalho. |
| `Exec` | Comando do sistema a executar, com argumentos separados por vírgula (ex.: `alacritty`, `screengrab, -f`). |
| `path` | Ação interna do LXQt, no lugar de `Exec` (ex.: `/panel/taskbar2/task_1`, `/panel/volume/up`). |

O nome da seção codifica a tecla: `%2B` é `+`, `%20` é espaço. Então
`Control%2BAlt%2BT.6` é `Ctrl+Alt+T`.

Atalhos seus relevantes para o teclado de 60%:

| Atalho | Ação |
|---|---|
| `Control%2BAlt%2BT.6` | Abre o Alacritty |
| `Control%2BAlt%2BE.3` | Abre o pcmanfm-qt |
| `Control%2BAlt%2BL.5` | Bloqueia a tela |
| `Control%2BAlt%2BD.2` | Mostra/oculta a área de trabalho |
| `Super_L.42` | Mostra/oculta o menu principal |
| `Meta%2B1` a `Meta%2B9` | Ativa a tarefa 1–9 da barra |
| `Control%2BF1` a `Control%2BF12` | Vai para o espaço de trabalho 1–12 |
| `Print.39` | Captura de tela (`screengrab, -f`) |
| `XF86*` | Teclas de mídia (volume, brilho, energia) |

Nota: as entradas `Meta+N` aparecem duas vezes (uma para `taskbar`, outra para
`taskbar2`), porque há duas barras de tarefas configuradas.

---

## lxqt-powermanagement.conf

| Chave | O que faz | Valor atual |
|---|---|---|
| `enableBatteryWatcher` | Mostra aviso de bateria fraca. | `true` |
| `enableIdlenessWatcher` | Ação quando o sistema fica ocioso (tela/sono). | `true` |
| `enableLidWatcher` | Reage ao fechar a tampa do notebook. | `true` |
| `runCheckLevel` | Nível de verificação de bateria (0–2). | `1` |

O comportamento da tampa também é controlado pelo NixOS em
`modules/monitors.nix` (`services.logind.lidSwitch`). O módulo
`modules/monitors.nix` está com erro de sintaxe e não é importado por nenhum
host, então hoje vale o padrão do LXQt.

---

## Arquivos quase vazios

Estes existem mas só marcam que a ferramenta já rodou. Servem como ponto de
partida para configurações futuras. A atribuição abaixo é a ferramenta
relacionada ao arquivo; os vazios podem ser gerados por mais de um componente.

| Arquivo | Ferramenta | Configura que |
|---|---|---|
| `lxqt-config-appearance.conf` | lxqt-config-appearance | Aparência (tema, fonte, ícones). Só tem `ControlGTKThemeEnabled` e o tamanho da janela. |
| `lxqt-config-input.conf` | lxqt-config-input | Mouse e touchpad. Só o tamanho da janela hoje. |
| `lxqt-config-file-associations.conf` | lxqt-config-file-associations | Associações de arquivos. Só o tamanho da janela. |
| `lxqt-runner.conf` | lxqt-runner | O diálogo de execução. Só `__userfile__=true`. |
| `notifications.conf` | lxqt-notificationd | Notificações. Só `__userfile__=true`. |
| `power.conf` | lxqt-powermanagement | Energia (tela, sono). Só `__userfile__=true`. |
| `windowmanagers.conf` | lxqt-session | Lista de WMs disponíveis. Só `__userfile__=true`. |
| `waylandwindowmanagers.conf` | lxqt-session | Lista de WMs Wayland. Só `__userfile__=true`. |

`__userfile__=true` é a marca que o LXQt usa para indicar que o arquivo foi
gerado pela interface. Não remova.

---

## Configurações do LXQt fora de `~/.config/lxqt`

São de componentes do LXQt, mas ficam em outros diretórios.

| Caminho | Componente | Conteúdo |
|---|---|---|
| `~/.config/pcmanfm-qt/` | pcmanfm-qt | Gerenciador de arquivos e área de trabalho: papel de parede, ícones da área de trabalho, menu de contexto, opções de visualização. |
| `~/.config/qterminal.org/qterminal.ini` | qterminal | Terminal padrão do LXQt: fonte, atalhos, cor, transparência, comportamento de saída (`AskOnExit`). |
| `~/.config/autostart/*.desktop` | lxqt-session | Programas que iniciam com a sessão. Os dois atuais são do próprio LXQt (monitor e touchpad). |
| `~/.config/fontconfig/fonts.conf` | lxqt-config-appearance | Antialiasing, hinting e DPI. Gerado pela interface e marcado "DO NOT EDIT". A versão declarativa é `modules/fonts.nix`. |

Nenhum desses está versionado hoje. Se quiser, o mesmo mecanismo de cópia
pode ser estendido para eles.
