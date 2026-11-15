# Tiling automático: Openbox + cortile

A sessão **LXQt** usa o **Openbox** como gerenciador de janelas (`window_manager=openbox`
em `~/.config/lxqt/session.conf`). O **cortile** roda por cima dele e organiza as janelas
em mosaico automaticamente. Como o Openbox trata painéis e a área de trabalho como
docks e desktop, o painel do LXQt mantém o comportamento esperado (largura, auto-hide e
espaço reservado).

## Onde fica cada parte

| Parte | Arquivo |
|---|---|
| Pacote (v2.5.2, tag do GitHub) | `pkgs/cortile.nix` |
| Instalação no sistema | `modules/cortile.nix` |
| Inicialização automática | `dotfiles/autostart/cortile.desktop` → `~/.config/autostart/` |
| Configuração | `dotfiles/cortile/config.toml` → `~/.config/cortile/config.toml` |

A configuração é copiada apenas na primeira vez (como o `lxqt-config`), porque o
cortile pode regravar o arquivo. Para versionar uma mudança feita pela interface,
copie o arquivo de `~/.config/cortile/config.toml` para `dotfiles/cortile/config.toml`.

## Atalhos principais (Super)

| Atalho | Ação |
|---|---|
| `Super+Home` / `Super+End` | Liga / desliga o tiling na tela atual |
| `Super+T` | Alterna ligado/desligado |
| `Super+Shift+D` | Liga / desliga as decorações da janela |
| `Super+R` | Desliga e restaura as janelas |
| `Super+BackSpace` | Restaura as proporções padrão |
| `Super+Left/Right/Up/Down` | Muda o layout (master à esquerda, direita, topo, base) |
| `Super+M` | Layout maximizado |
| `Super+Return` | Tela cheia |
| `Super+Next/Prior` | Próximo / anterior ciclo de layout |
| `Super+KP_2` / `KP_8` | Foco na próxima / anterior |
| `Super+KP_5` | Torna a janela ativa a master |
| `Super+KP_3` / `KP_1` | Aumenta / diminui a área master |
| `Super+Shift+=` / `Super+-` | Aumenta / diminui o número de slaves |
| `Super+KP_Add` / `KP_Subtract` | Aumenta / diminui o número de masters |

`Ctrl+Super+...` aplica o comando a todas as telas; `Alt+Super+...` a todos os workspaces.
A lista completa está em `dotfiles/cortile/config.toml`, seção `[keys]`.

Alguns atalhos do Openbox e do LXQt continuam reservados:

- `Super+D` mostra a área de trabalho (Openbox); por isso a decoração usa `Super+Shift+D`.
- `Super+Space` alterna US/BR (`grp:win_space_toggle`); por isso o maximizado usa `Super+M`.
- `Super+E` abre o Konqueror e `Super+F1..F4` trocam de desktop no Openbox; não use esses combos no cortile.
- `Super` sozinho foi movido do menu principal para `Alt+F1`, para não abrir o menu no meio dos combos.

Os atalhos antigos `Ctrl+Shift+...` foram removidos: esse espaço volta a pertencer aos aplicativos (por exemplo, `Ctrl+Shift+T` reabre aba no navegador).

## Ajustes que podem ser necessárioss

- **Painel não reservado:** se o cortile ocupar a área do painel, ajuste
  `edge_margin = [top, right, bottom, left]` em `config.toml` (por exemplo,
  `[0, 0, 32, 0]` para um painel de 32 px embaixo).
- **Janelas que não devem entrar no tiling:** adicione-as em `window_ignore`, como
  já está para `nm`, `polkit`, `blueman` e outras.

## Problema resolvido: decoração cortada e espaço vazio embaixo

**Sintomas:** decoração das janelas cortada no topo (janelas "acima da tela") e uma
faixa vazia embaixo maior que o gap.

**Causa:** o `lxqt-panel` publicava `_NET_WM_STRUT_PARTIAL` inválido
(`4294967272`, que é `-28` como int32 — a posição do painel escondido no auto-hide).
O cortile lê esses struts como `uint` sem validar, sua área de desktop ficava com
coordenada gigante e, ao ser truncada no protocolo X, as janelas saíam em y negativo
com a altura errada.

**Correção aplicada:** `reserve-space=false` nas duas seções de painel em
`~/.config/lxqt/panel.conf` (arquivo **não versionado** no repo — contém caminhos
`/nix/store`). Com isso os struts saem zerados e o cortile usa a tela inteira:

```sh
grep -n reserve-space ~/.config/lxqt/panel.conf   # deve ser false nas duas seções
```

Efeito: as janelas ocupam a tela toda, com apenas o gap uniforme de
`window_gap_size` (10 px) nas bordas. O painel, em auto-hide, aparece **por cima**
das janelas quando o mouse vai à borda (não reserva espaço).

Para voltar a reservar espaço (painel sempre visível por cima da área de tiling),
reverta para `reserve-space=true` — mas aí o bug do strut volta a corromper o
cortile enquanto o painel está escondido; nesse caso desative o auto-hide
(`hidable=false`) para o painel ficar em posição fixa (y=0 / y=736) com strut válido.

**Diagnóstico útil:**

```sh
# struts dos painéis (ideal: tudo zero, ou 32 numa borda se reserve-space=true)
for id in $(xprop -root _NET_CLIENT_LIST | grep -o '0x[0-9a-f]*'); do
  xprop -id $id WM_CLASS 2>/dev/null | grep -q lxqt-panel && xprop -id $id _NET_WM_STRUT_PARTIAL
done

# geometria: moldura deve começar em y>=0 e terminar simétrica embaixo
nix-shell -p xwininfo --run 'xwininfo -id <janela>'
```

Observação: os processos do painel têm `comm` truncado (`.lxqt-panel-wra`), então
`pkill -x lxqt-panel` **não** funciona — mate por PID
(`pgrep -f '^/run/current-system/sw/bin/lxqt-panel$'`). Dois processos ao mesmo
tempo é normal: `panels=panel1, panel_{uuid}` (um por painel); o `lxqt-session`
relança o painel se ele morrer.

## Verificação feita

1. `dry-build` passou e o pacote do cortile compila.
2. Na sessão real: struts zerados, `_NET_WORKAREA = 0,0,1366,768`, moldura das
   janelas de y=10 a y=758 (gap de 10 px simétrico), decoração não cortada,
   auto-hide do painel funcionando (painel escondido em y=-28, aparece no hover).
3. Testar `Super+Home` e os layouts.

## Reverter

- Para voltar a uma sessão sem tiling: `Super+End` na sessão, ou remover o
  autostart e rodar o `update`.
- Para voltar ao i3: em `dotfiles/lxqt/session.conf`, use `window_manager=i3`, descomente
  `../../modules/i3.nix` em `hosts/laptop/default.nix` e rode `update`.
