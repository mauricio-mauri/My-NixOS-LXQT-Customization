{ ... }:

{
  nix.settings.experimental-features = [ "nix-command" ];
  nixpkgs.config.allowUnfree = true;
  programs.nix-ld.enable = true;

  nix.settings.auto-optimise-store = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  zramSwap.enable = true;
}
