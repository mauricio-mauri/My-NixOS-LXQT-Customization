{ pkgs, ... }:

{
   environment.systemPackages = with pkgs; [ bluetui ];

   hardware.bluetooth = {
   enable = true;
   powerOnBoot = true;
   };

   services.blueman.enable = true;
}
