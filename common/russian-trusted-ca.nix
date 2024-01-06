{ config, pkgs,... }:

let 
  root_ca = pkgs.fetchurl {
    url = "https://gu-st.ru/content/lending/russian_trusted_root_ca_pem.crt";
    hash = "sha256-k2pD/qbo5SW8wPgazZw9IbT8S5torOp5BtaYAFr8ZQQ=";
  };
  sub_ca = pkgs.fetchurl {
    url = "https://gu-st.ru/content/lending/russian_trusted_sub_ca_pem.crt";
    hash = "sha256-8K5YnzZ3TynvNkj3mEsI1C/M5vH/7rYjbXc9rrJ0TqY=";
  };
in {
  security.pki.certificateFiles = [ "${root_ca}" "${sub_ca}" ];
}
