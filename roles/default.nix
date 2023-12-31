{
  imports = [
    ./airplay-server.nix
    ./design.nix
    ./devel.nix
    ./gaming.nix
    ./graphical.nix
    ./latex.nix
    ./media-client.nix # TODO: media-server
    ./router.nix
    ./ntp-server.nix
    ./torrent.nix
    ./virtualisation.nix
    ./yggdrasil-client.nix
    ./yggdrasil-peer.nix

    ./server/nginx.nix
    ./server/ivabus-dev.nix
    ./server/slides-ivabus-dev.nix
    ./server/urouter.nix
  ];
}
