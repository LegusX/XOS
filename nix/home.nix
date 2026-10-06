{ pkgs, ... }:

{
  imports = [
    ./theme.nix
  ];

  home.username = "logan";
  home.homeDirectory = "/var/home/logan";

  home.stateVersion = "26.05";

  targets.genericLinux.enable = true;

  home.packages = with pkgs; [
    eza
  ];
}