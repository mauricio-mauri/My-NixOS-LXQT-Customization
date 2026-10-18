{ pkgs, ... }:

let
  monsgeek-driver = pkgs.callPackage ../pkgs/monsgeek-driver.nix { };
in
{
  environment.systemPackages = [ monsgeek-driver ];

  services.udev.packages = [ monsgeek-driver ];
}
