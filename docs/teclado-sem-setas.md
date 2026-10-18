# Navegação sem setas (teclado 60%)

O teclado atual é um MonsGeek (60%), sem setas, Home, End, Page Up/Down, Insert e Delete próprios. Este guia lista o que substitui cada tecla em cada programa configurado no repositório.

## Antes de tudo: camada Fn do teclado

Teclados 60% costumam trazer as teclas que faltam em uma camada **Fn**. A combinação não é fixa: confira a legenda impressa nas teclas ou o software do fabricante. Em geral, as setas ficam em `Fn + H/J/K/L` ou em `Fn + teclas próximas`, e Delete em `Fn + Backspace`. Essa configuração fica gravada no próprio teclado, não no NixOS.

## Zellij

O Zellij intercepta várias combinações `Ctrl` antes que cheguem ao shell. Para entregar todas as teclas diretamente ao programa (zsh, nvim, etc.), pressione `Ctrl+g` para entrar no modo locked; `Ctrl+g` de novo volta ao modo normal.

### Atalhos sem modo (funcionam direto)

| Ação | Tecla |
|---|---|
| Mover foco entre painéis | `Alt+h` `Alt+j` `Alt+k` `Alt+l` |
| Mover aba para esquerda/direita | `Alt+i` / `Alt+o` |
| Ir para a aba 1–9 | `Alt+1` … `Alt+9` |
| Nova aba | `Alt+t` |
| Novo painel | `Alt+n` |
| Painel flutuante on/off | `Alt+f` |
| Aumentar / diminuir painel | `Alt+=` / `Alt+-` |
| Layout anterior / próximo | `Alt+[` / `Alt+]` |
| Trocar painel no grupo | `Alt+p` |

### Modos (entra com `Ctrl+letra`, sai com `Esc`)

| Modo | Entrar | Dentro do modo |
|---|---|---|
| Pane | `Ctrl+p` | `h j k l` mover foco; `n` novo; `r` dividir à direita; `d` dividir abaixo; `x` fechar painel; `f` tela cheia |
| Tab | `Ctrl+t` | `h` / `l` trocar aba; `1`–`9` ir para aba; `n` nova aba; `x` fechar aba; `r` renomear |
| Resize | `Ctrl+n` | `h j k l` redimensionar |
| Move | `Ctrl+h` | `h j k l` mover o painel |
| Scroll | `Ctrl+s` | `j` / `k` linha; `u` / `d` meia página; `h` / `l` página; `s` buscar |
| Session | `Ctrl+o` | `d` destacar sessão; `w` gerenciador de sessões |

Dentro do modo **Scroll**, `h j k l` substituem as setas e Page Up/Down.

### Sair

Não há mais atalho para encerrar a sessão com `Ctrl+q`. Para encerrar, feche o último painel com `exit`. Com `ZELLIJ_AUTO_EXIT=true`, o terminal fecha junto. `Ctrl+o` + `d` destaca a sessão e também fecha o terminal.

## Zsh

O modo Emacs está fixado (`bindkey -e` no `dotfiles/zsh/.zshrc`).

| Ação | Tecla | Substitui |
|---|---|---|
| Histórico de comandos (busca) | `Ctrl+r` (fzf) | Seta para cima |
| Buscar arquivo | `Ctrl+t` (fzf) | — |
| Entrar em diretório com fzf | `Alt+c` (fzf) | — |
| Início / fim da linha | `Ctrl+a` / `Ctrl+e` | Home / End |
| Caractere para trás / frente | `Ctrl+b` / `Ctrl+f` | Setas esquerda / direita |
| Palavra para trás | `Alt+b` | Ctrl+seta esquerda |
| Apagar caractere | `Backspace` ou `Ctrl+d` | Delete |

Atenção: `Ctrl+d` em uma linha vazia encerra o shell. Com `ZELLIJ_AUTO_EXIT=true`, isso fecha o terminal. Use `Ctrl+d` só com texto na linha.
| Apagar até o início da linha | `Ctrl+u` | — |
| Apagar palavra anterior | `Ctrl+w` | — |
| Limpar tela | `Ctrl+l` | — |

Notas:

- `Ctrl+p` e `Ctrl+n` (histórico anterior/próximo, que também funcionam no Emacs) são usados pelo Zellij no modo Pane e Resize. Dentro do Zellij, use `Ctrl+r` para o histórico.
- `Ctrl+b` também é tecla do Zellij (modo tmux). Se não responder dentro do Zellij, use `Ctrl+g` antes.
- `Alt+f` é usado pelo Zellij (painel flutuante). Para avançar palavra, use `Ctrl+f` repetidamente, ou pressione `Ctrl+g` antes.

## Fzf (listas)

Dentro das listas, use `Ctrl+j` / `Ctrl+k` (ou `Ctrl+n` / `Ctrl+p`) para descer e subir. `Enter` confirma e `Esc` cancela.

## Neovim / Vim

O `dotfiles/vim/.vimrc` mapeia `j` e `k` para `gj` e `gk`, para navegar linhas quebradas. Todo o resto usa as teclas do Vim:

| Ação | Tecla |
|---|---|
| Esquerda / baixo / cima / direita | `h` `j` `k` `l` |
| Início / fim da linha | `0` (ou `^`) / `$` |
| Próxima / anterior palavra | `w` / `b` |
| Início / fim do arquivo | `gg` / `G` |
| Meia página para cima / baixo | `Ctrl+u` / `Ctrl+d` |
| Entrar em modo de inserção | `i` (ou `a` para depois do cursor) |
| Voltar ao modo normal | `Esc` |
| Apagar caractere | `x` |
| Salvar / sair | `:w` / `:q` |

Dentro do Zellij, `Ctrl+b` (página para cima no Vim) é interceptado. Use `Ctrl+u` ou `Ctrl+g` antes.

## Alacritty

| Ação | Tecla |
|---|---|
| Nova janela | `Ctrl+Shift+N` ou `Alt+Enter` |
| Copiar / colar | `Ctrl+Shift+C` / `Ctrl+Shift+V` |

## Casos em que você ainda precisa de uma seta

- **Mover o cursor por uma linha longa:** use `Ctrl+a`/`Ctrl+e` no shell, ou `0`/`$` no Vim.
- **Navegar em menus gráficos (LXQt, Firefox):** use `Tab` e `Shift+Tab` para mudar de campo; em listas, use a camada Fn do teclado.
- **Selecionar texto no shell:** o modo Emacs não tem seleção com teclado. Use o mouse: no Alacritty, arraste para selecionar; no Zellij, segure `Shift` enquanto arrasta para que o terminal faça a seleção.

## Camada de navegação com CapsLock (keyd) — desativada

Configurada em `modules/keyd.nix`, mas **desativada por enquanto**: o import está comentado em `hosts/laptop/default.nix`. Para reativar, descomente a linha e rode o `switch`. O `keyd` é um daemon que intercepta o teclado antes do sistema gráfico, então funciona no LXQt.

- **CapsLock tocado** (solto rapidamente): envia `Esc`.
- **CapsLock segurado**: ativa a camada `nav` enquanto ele estiver pressionado.

| Com CapsLock segurado | Resultado |
|---|---|
| `h` `j` `k` `l` | Esquerda, baixo, cima, direita |
| `y` / `o` | Home / End |
| `u` / `n` | Page Up / Page Down |
| `i` | Insert |
| `Backspace` | Delete |

Efeitos colaterais:

- CapsLock deixou de travar maiúsculas. Ele virou a tecla da camada.
- A troca de layout do LXQt (`Super+Espaço`, em `~/.config/lxqt/session.conf`) continua funcionando.
- O keyd afeta todos os teclados (`ids = [ "*" ]` em `modules/keyd.nix`). Para restringir ao MonsGeek, troque `"*"` pelo ID dele (`sudo keyd monitor` mostra os IDs).

Depois do `switch`, o serviço `keyd` inicia sozinho. Para aplicar sem reiniciar: `sudo systemctl restart keyd`.
