{ pkgs, ... }:

{
  home.packages = with pkgs; [
    tree
    jq
    yq-go
    file
    which
  ];
}
