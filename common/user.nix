{ config, pkgs, ... }:

let
  secrets = import ../secrets.nix;
in {
  users.users.ivabus = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    uid = 1000;
    packages = with pkgs; [
      tree
      cargo
      rustc
      neofetch
      gitFull
    ];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      # Air M2 macOS
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC6HY6er37FUz2tPQnwq5SUQZ5KHmMpGQA5yNlxPOyoCV+uvdx/cU8KF7jlFoyBC9xf2FvNyB8H1MZ6t2eUs4m/pVMpoBbNSTZLSxlvv2n4HuxL2Sg3qPdioJOyxDfnXA4OIZ+Tc+z4zM3ZnPJm1ccGW7W+YPhZ7GhBpl5wlMw+m06dCt8wfdDA4fuf4brnLt1ZMs4aOtVM8u4ZEtMs3IVXVUgtRH5m0RXZ94s7RkrUHhl2UOkOclhkQOiQop9RuJMjpi+iYkDYCniuGCKcKPrmi1+qicKM8KyrYGqR7FkUvzr+H8XtJXu++Kvmjcn54jDYqM4sq/MNL2rf8QaIUGLwiq2ljH2dGamElvElWZoXQBGPp4L80IEbaMVISIcvcNj+8cKW3rPvEUK5iT8jCkIOUwm1oo70YawS5VXTPLDsZif12QduTcJhVJekEaP0ZSifO52zeJksj0adwiEMJPqm7bIk5Y+9dCbQH7PtkWY4Tw3bdGNsYnTXC80MeEfrIKE="
    ];
    hashedPassword = secrets.hashed-password;
  };

  programs.zsh = {
    enable = true;
  };

  programs.gnupg.agent.enable = true;
  programs.ssh.startAgent = true;

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.ivabus = {
    gtk = {
      enable = true;
      theme = {
        name = "Catppuccin-Macchiato-Standard-Blue-dark";
        package = pkgs.catppuccin-gtk.override {
          accents = [ "blue" ];
          tweaks = [ "rimless" ];
          size = "standard";
          variant = "macchiato";
        };
      };
      iconTheme = {
        name = "Mint-Y-Blue";
        package = pkgs.cinnamon.mint-y-icons;
      };
      cursorTheme = {
        name = "Catppuccin-Macchiato-Dark-Cursors";
        package = pkgs.catppuccin-cursors.macchiatoDark;
      };
      font = {
        name = "Ubuntu";
        size = 9;
        package = pkgs.ubuntu_font_family;
      };
    };
    home.pointerCursor = {
      name = "Catppuccin-Macchiato-Dark-Cursors";
      package = pkgs.catppuccin-cursors.macchiatoDark;
      x11.defaultCursor = "Catppuccin-Macchiato-Dark-Cursors";
    };
    programs.git = {
      enable = true;
      userName = "Ivan Bushchik";
      userEmail = "ivabus@ivabus.dev";
      signing.key = "DF1D910360471F0CCF076E449F6DDABE11A2674D";
      signing.signByDefault = true;
      package = pkgs.gitAndTools.gitFull;
    };
    home.stateVersion = "23.05";
  };
}