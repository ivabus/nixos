{

  description = "ivabus's NixOS Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };


  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    # Stella = Unchartevice 6540 (Ryzen 3 3250U, 16GB RAM)
    nixosConfigurations."stella" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        home-manager.nixosModules.home-manager
        ./common/base.nix
        ./common/user.nix
        ./common/laptop.nix
        ./common/networking.nix
        ./common/locale.nix
        ./common/remote-access.nix
        ./roles/graphical.nix
        ./roles/latex.nix
        #./roles/gaming.nix
        ./roles/devel.nix
        ./roles/yggdrasil-client.nix
        ./machines/stella/configuration.nix
        ./machines/stella/hardware.nix
      ];
    };

    # Vetus = iMac 27" 2017, i5, 64 GB RAM
    nixosConfigurations."vetus" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        home-manager.nixosModules.home-manager
        ./common/base.nix
        ./common/user.nix
        ./common/laptop.nix
        ./common/networking.nix
        ./common/locale.nix
        ./common/remote-access.nix
        ./roles/graphical.nix
        ./roles/latex.nix
        ./roles/gaming.nix
        ./roles/devel.nix
        ./roles/yggdrasil-client.nix
        ./machines/vetus/configuration.nix
        ./machines/vetus/hardware.nix
      ];
    };
    /* These machines will be configured later. */
    /*
    # Celerrime = MacBook Air M2
    nixosConfigurations."celerrime" = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      modules = [
        ./common/base.nix
        ./common/user.nix
        ./roles/laptop.nix
        ./roles/graphical.nix
        ./machines/celerrime/configuration.nix
        ./machines/celerrime/hardware.nix
      ];
    };
    # Effundam = MacBook Air M1 (server usage). Will not be added to flake.nix until thunderbolt and apfs proper support
    nixosConfigurations."effundam" = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      modules = [
        ./common/base.nix
        ./common/user.nix
        ./roles/laptop.nix
        ./machines/effundam/configuration.nix
        ./machines/effundam/hardware.nix
      ];
    };
    */
  };
}