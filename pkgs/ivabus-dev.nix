{ pkgs ? import <nixpkgs> { }, bundlerEnv, ... }:
let
  version = "6b41144ec6f1d31c35cd12e3fd38ba6d34e481db";
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
    bundle exec jekyll build 
  '';

  installPhase = ''
    mkdir -p $out
    cp -r _site/* $out/
  '';
}
