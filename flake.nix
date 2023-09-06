{

  description = "ivabus's NixOS Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    apple-silicon-support.url = "github:tpwrules/nixos-apple-silicon";
  };

  outputs =
    { self, nixpkgs, home-manager, apple-silicon-support, ... }@inputs: {
      # Stella = Unchartevice 6540 (Ryzen 3 3250U, 16GB RAM)
      nixosConfigurations."stella" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ home-manager.nixosModules.home-manager ./machines/stella ];
      };

      # Vetus = iMac 27" 2017, i5, 64 GB RAM
      nixosConfigurations."vetus" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ home-manager.nixosModules.home-manager ./machines/vetus ];
      };

      # Celerrime = MacBook Air M2
      nixosConfigurations."celerrime" = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          home-manager.nixosModules.home-manager
          apple-silicon-support.nixosModules.apple-silicon-support
          ./machines/celerrime
        ];
      };

      # Raspberry Pi 4B 2GB RAM
      nixosConfigurations."rubusidaeus" = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          "${nixpkgs}/nixos/modules/installer/sd-card/sd-image-aarch64.nix"
          home-manager.nixosModules.home-manager
          ./machines/rubusidaeus
        ];
      };

      # These machines will be configured later.
      /* # Effundam = MacBook Air M1 (server usage). Will not be added to flake.nix until thunderbolt and apfs proper support
         nixosConfigurations."effundam" = nixpkgs.lib.nixosSystem {
           system = "aarch64-linux";
           modules = [
             home-manager.nixosModules.home-manager
             apple-silicon-support.nixosModules.apple-silicon-support
             ./machines/effundam
           ];
         };
      */
    };
}
