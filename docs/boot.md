# Boot e recuperação

O GRUB mostra o menu por cinco segundos para facilitar a seleção de gerações anteriores durante a configuração inicial. O dispositivo GRUB é definido pelo perfil do host, enquanto o módulo comum configura o comportamento e o Plymouth.

Cada `nixos-rebuild switch` bem-sucedido cria uma geração selecionável no boot. Antes de experimentar opções de boot ou drivers, prefira `nixos-rebuild test`; para desfazer uma geração ativa, use:

```sh
sudo nixos-rebuild switch --rollback
```

Também é possível escolher uma geração anterior no menu GRUB. A coleta de lixo automática mantém gerações recentes, mas não substitui backup dos dados pessoais.

O perfil do laptop presume instalação BIOS/GRUB em `/dev/sda`, correspondente à sessão observada. Confirme o modo de boot pelo live USB antes da instalação; se usar UEFI, ajuste as opções de boot do perfil do laptop antes de ativá-lo.
