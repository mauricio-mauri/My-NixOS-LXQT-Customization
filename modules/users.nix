{ pkgs, ... }:

{
  users.users.mauri = {
    isNormalUser = true;
    description = "Mauricio";
    extraGroups = [ "networkmanager" "wheel" "docker" "input" ];
    shell = pkgs.zsh;
  };
}
