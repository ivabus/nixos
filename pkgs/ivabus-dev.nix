{ pkgs ? import <nixpkgs> { }, bundlerEnv ? pkgs.bundlerEnv, ... }:
let
  version = "a1a564f2640e6694ec89a85595b7aad5f3b62395";
  repo = builtins.fetchGit {
    url = "https://github.com/ivabus/website";
    rev = version;
  };

  gems = bundlerEnv {
    name = "ivabus-dev";
    ruby = pkgs.ruby;

    gemdir = "${repo}/.";
  };
in pkgs.stdenv.mkDerivation {
  inherit version;
  name = "ivabus-dev";
  src = repo;

  buildInputs = with pkgs; [
    gems
    # nokogiri dependencies
    zlib
    libiconv
    libxml2
    libxslt
    # jekyll wants a JS runtime
    nodejs-slim
  ];

  buildPhase = ''
    echo "commit_id: ${version}" >> _config.yml
    bundle exec jekyll build 
  '';

  installPhase = ''
    mkdir -p $out
    cp -r _site/* $out/
  '';
}
