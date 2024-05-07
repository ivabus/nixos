{ config, ... }:
let
  canaryHash = builtins.hashFile "sha256" ./secrets/canary;
  expectedHash =
    "bc6f38a927602241c5e0996b61ebd3a90d5356ca76dc968ec14df3cd45c6612c";
in if (canaryHash != expectedHash && config.my.features.secrets) then
  abort "Secrets are enabled and not readable. Have you run `git-crypt unlock`?"
else {
  hashed-password = builtins.readFile ./secrets/hashed-password;
  maas-address = builtins.readFile ./secrets/maas-address;
  yggdrasil-peer = builtins.readFile ./secrets/yggdrasil-peer;
  yggdrasil-password = builtins.readFile ./secrets/yggdrasil-password;
  wireguard = import ./secrets/wireguard.nix;
}
