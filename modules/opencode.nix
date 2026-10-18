{ config, pkgs, ... }:
let
  unstable = import (builtins.fetchTarball "https://nixos.org") { 
    config = pkgs.config; 
  };
in {
  environment.systemPackages = with pkgs; [
    unstable.opencode
  ];
}

