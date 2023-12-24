{ config, pkgs, lib, secrets, home-manager, ... }:

let
  cfg = config.my.users;
  keys = [
    # Celerrime macOS
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF0GX4/09I5B7nVeU3EKw58VyKNsbwpi4KzuJrgpoVfR ivabus@celerrime-x"
    # Celerrime NixOS
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPKp/t0ImyVYqaxVda8XP6fcxJVkf+Sc4oo3x5a5j2Gk ivabus@celerrime"
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
          neofetch # I use NixOS BTW
          duf
          htop
        ];
        shell = pkgs.zsh;
        openssh.authorizedKeys.keys = keys;
        hashedPassword = secrets.hashed-password;
      };
      programs.gnupg.agent.enable = true;
    })

    (lib.mkIf (cfg.user.enable) {
      users.users.user = {
        isNormalUser = true;
        group = "users";
        extraGroups = [ "video" "audio" "networkmanager" ];
        uid = 1001;
        packages = with pkgs; [
          tree
          neofetch # I use NixOS BTW
          duf
          htop
        ];
        shell = pkgs.zsh;
        openssh.authorizedKeys.keys = keys;
        password = "12345";
      };
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
