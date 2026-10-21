{ pkgs, ... }:

{
  # Gerenciador de janelas usado pela sessão LXQt (X11) via window_manager=i3
  # em ~/.config/lxqt/session.conf. A barra vem do lxqt-panel, não do i3bar.
  services.xserver.windowManager.i3.enable = true;

  # Usado pelo exec de fundo em dotfiles/i3/config.
  environment.systemPackages = [ pkgs.xsetroot ];
}
