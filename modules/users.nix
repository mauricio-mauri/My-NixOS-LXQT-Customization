{ ... }:

{
  users.users.mauri = {
    isNormalUser = true;
    description = "Mauricio";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };
}
