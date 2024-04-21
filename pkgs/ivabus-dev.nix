{ pkgs ? import <nixpkgs> { }, bundlerEnv ? pkgs.bundlerEnv, ... }:
let
  version = "082594252a1542516effc398aa45476be03aa6b3";
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
