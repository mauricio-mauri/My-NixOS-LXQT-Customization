{ pkgs, ... }:

{
  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
    package = pkgs.docker_29;
    daemon.settings.mtu = 1400;
  };
}
