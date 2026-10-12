# Diagnóstico rápido

## Rebuild não encontra hardware-configuration.nix

Gere o arquivo no host atual e salve-o localmente no diretório `hosts/laptop/` ou `hosts/vm/`, conforme o perfil. Esses arquivos são ignorados pelo Git de propósito.

## Perfil errado

Confira qual arquivo passou a `-I nixos-config=...`. `configuration.nix` seleciona o laptop; `configuration-vm.nix` seleciona a VM.

## OpenCode não aparece

Após aplicar a geração, execute:

```sh
command -v opencode
opencode --version
```

O executável é fornecido por `pkgs.opencode` no módulo `dev-tools.nix`; o login/configuração de provedor é separado e fica no perfil do usuário.

## Recuperar geração

Se o sistema ainda inicia, use `sudo nixos-rebuild switch --rollback`. Caso contrário, selecione uma geração anterior no GRUB. Evite apagar gerações antes de confirmar que a nova inicializa corretamente.
