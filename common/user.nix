{ config, pkgs, lib, secrets, home-manager, ... }:

let
  cfg = config.my.users;
  keys = [
    # Celerrime macOS
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF0GX4/09I5B7nVeU3EKw58VyKNsbwpi4KzuJrgpoVfR ivabus@celerrime-x"
    # Celerrime NixOS
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMDgplnr0Rgv6osbq7pwmFuKQ1/egXg52gbLmswuvCiT ivabus@celerrime"
  ];
in rec {
  options.my.users = {
    ivabus.enable = lib.mkEnableOption "Enable ivabus user";
    user.enable = lib.mkEnableOption "Enable general-purpose user";
  };
  config = lib.mkMerge [
    (lib.mkIf (cfg.ivabus.enable) {
      my.features.secrets = lib.mkForce true;

      users.groups.ivabus = { gid = 1000; };
      users.users.ivabus = {
        isNormalUser = true;
        group = "ivabus";
        extraGroups = [ "users" "wheel" ];
        uid = 1000;
        packages = with pkgs; [
          tree
          fastfetch # I use NixOS BTW
          duf
          htop
        ];
        shell = pkgs.zsh;
        openssh.authorizedKeys.keys = keys;
        hashedPassword = secrets.hashed-password;
      };
      programs.gnupg.agent.enable = true;
      home-manager.users.ivabus.home.stateVersion = "24.05";
    })

    (lib.mkIf (cfg.user.enable) {
      users.users.user = {
        isNormalUser = true;
        group = "users";
        extraGroups = [ "video" "audio" "networkmanager" ];
        uid = 1001;
        packages = with pkgs; [
          tree
          fastfetch # I use NixOS BTW
          duf
          htop
        ];
        shell = pkgs.zsh;
        openssh.authorizedKeys.keys = keys;
        password = "12345";
      };
      home-manager.users.user.home.stateVersion = "24.05";
    })

    ({
      users.mutableUsers = false;
      users.users.root = {
        hashedPassword = null;
        openssh.authorizedKeys.keys = keys;
      };

      environment.shells = [ pkgs.zsh ];
      programs.zsh = {
        enable = true;
        promptInit = "";
      };

      programs.ssh.startAgent = true;

      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
    })
  ];
}
