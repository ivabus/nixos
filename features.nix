{ lib, config, ... }:

{
  options.my.features.secrets = lib.mkEnableOption "Enable secrets decrypting";
}
