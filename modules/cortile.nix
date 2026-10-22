{ pkgs, ... }:

let
  cortile = pkgs.callPackage ../pkgs/cortile.nix { };
in
{
  # Tiling automático que roda por cima do Openbox (sessão LXQt, window_manager=openbox).
  # A inicialização é feita pelo autostart em ~/.config/autostart/cortile.desktop.
  environment.systemPackages = [ cortile ];
}
