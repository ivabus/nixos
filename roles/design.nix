{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    inkscape
    gimp
    imagemagick
  ];
}
