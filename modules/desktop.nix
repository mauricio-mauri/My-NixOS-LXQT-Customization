{ pkgs, ... }:
{
  services.xserver.enable = true;
  services.xserver.desktopManager.lxqt.enable = true;
  services.xserver.displayManager.lightdm.enable = true;
  hardware.graphics.enable = true;

  services.xserver.xkb = {
    layout = "us,br";
    variant = "";
  };

  services.printing.enable = true;

  # XScreenSaver 6.13 usa PAM para desbloquear. Sem este serviço, o PAM cai
  # em /etc/pam.d/other (pam_deny) e qualquer senha é recusada.
  security.pam.services.xscreensaver = {
    enable = true;
  };

  # O xscreensaver-auth precisa ser setuid root; o pacote procura o binário
  # em /run/wrappers/bin (já incluído no PATH dele).
  security.wrappers.xscreensaver-auth = {
    setuid = true;
    owner = "root";
    group = "root";
    source = "${pkgs.xscreensaver}/libexec/xscreensaver/xscreensaver-auth";
  };

  environment.systemPackages = with pkgs; [
    alacritty
	kitty
    foot
    firefox
	vivaldi
    papirus-icon-theme
    kdePackages.dolphin
  ];
}
