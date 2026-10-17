{ config, pkgs, ... }:

{
  services.xserver = {
    xrandrHeads = [
       { output = "HDMI-1"; primary = true; }
    ];
    displayManager.sessionCommands = ''
       $(pkgs.xorg.xrandr}/bin/xrandr --output LVDS-1 --off
    '';
  };

  services.logind.lidSwitch = "ignore";
  services.logind.lidSwitchExternalPower = "ignore";
  services.logind.lidSwitchDocked = "ignore";
}
