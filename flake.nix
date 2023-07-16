{

  description = "ivabus's NixOS Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };


  outputs = { self, nixpkgs, ... }@inputs: {

    nixosConfigurations."stella" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./common/base.nix
        ./common/laptop.nix
        ./common/user.nix
        ./common/graphical.nix
        ./machines/stella/configuration.nix
        ./machines/stella/hardware.nix
      ];
    };

    /* These machines will be configured later. */
    /*
    nixosConfigurations."celerrime" = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      modules = [
        ./machines/celerrime/configuration.nix
        ./user.nix
        ./graphical.nix
      ];
    };

    nixosConfigurations."vetus" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./machines/vetus/configuration.nix
        ./
      ];
    };
    */
  };
}