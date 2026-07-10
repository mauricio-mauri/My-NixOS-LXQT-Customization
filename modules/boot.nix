{ pkgs, ... }:

{
  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
    useOSProber = false;
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;
}
