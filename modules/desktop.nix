{ pkgs, inputs, ... }:

{
  programs.mango.enable = true;
  programs.dank-material-shell = {
    enable = true;
    dgop.package = inputs.dgop.packages.${pkgs.system}.default;
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --cmd mango";
        user = "greeter";
      };
    };
  };

  services.xserver.xkb = {
    layout = "us,br";
    variant = "";
  };

  services.printing.enable = true;
}
