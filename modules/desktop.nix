{ pkgs, inputs, ... }:

{
  programs.mango.enable = true;

  programs.dank-material-shell = {
    enable = true;
    quickshell.package = inputs.quickshell.packages.${pkgs.system}.quickshell;
    dgop.package = inputs.dgop.packages.${pkgs.system}.default;
  };

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  services.xserver.xkb = {
    layout = "us,br";
    variant = "";
  };

  services.printing.enable = true;

  environment.systemPackages = with pkgs; [
    alacritty
    foot
    papirus-icon-theme
  ];
}
