{
  imports = [
    ./design.nix
    ./devel.nix
    ./gaming.nix
    ./graphical.nix
    ./latex.nix
    ./media-client.nix # TODO: media-server
    ./ntp-server.nix
    ./torrent.nix
    ./virtualisation.nix
    ./yggdrasil-client.nix

    ./server/nginx.nix
    ./server/ivabus-dev.nix
  ];
}
