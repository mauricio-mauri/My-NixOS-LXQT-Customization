{ pkgs, ... }:

{
  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
    package = pkgs.docker_29;
  };
}
