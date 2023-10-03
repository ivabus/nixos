{ lib, config, ... }:
let
in {
  options.my.features.secrets = lib.mkEnableOption "Enable secrets decrypting";
}
