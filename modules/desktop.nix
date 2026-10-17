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

  environment.systemPackages = with pkgs; [
    alacritty
    foot
    firefox
    papirus-icon-theme
    kdePackages.dolphin
  ];
}
