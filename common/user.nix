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

      # Stella
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDXWPxd1uVVxEARVezy0s0LZ9fC/Mif6s218oNWDyJNqZMnAiaMwwP/mGHqCy1OXFCb8/5Kv3AM+z6sxY4mIvyXhx3lPW841HoOlJxR+JQ50qgxon/oCXjKFVMZjFptRtexgQLhubhjyINagj7T/K6UjsfC9sIG5DUJdem0O8ZD/8EqvIrkeNGP52klJM3sR4vhXMNwOIPkukNOMq+OLXgAaCXRImc53N+Whi/tCaxxr/Nen5CVGo9raAekRKaiBLKvgboXYnxzNFxiecUe7mqPbyE2bcnJ+rDC7UlwrNYGyIQ/8POjQwbanFxT4UJhS5ib6/hSpia0eYaSiutBqU3fQcIXrmTQWOrGPdrUsLHw5xGMfwnPmoDFMYHdcchU0v6QijbrHrsqVV/bikWoQF4JT7PCwOejfVowOioPghvW2u34gTyMKPkueaMk0w8Jq45V0meneyN5SbobqZX3XFze4Uz3BN8nuiZB6pFRPv0eKLqEqX8+nST9uQDBkqKTvwE= ivabus@stella"

      # Celerrime
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC/x2Xkj/w8Q6Ri+iP6b3dzY4KZ1q1RMqZmlFiiki/BuK+1Z+NMY6e6zgTJs1hSsd42XaTotHs75BcO13ou4Sa6p5Gmn+lC1tUWSEUhBoJimFmGp7E9wZjtzHIZyVRj7WMBUmbn4tgsnlGTS1rc2ODwBC7YLpqVzmgkLE3NyFXgSYhCRddvj16netrF6pQp+I/iTCblnhn8LOsnZMSU0aT92ybcLp6glwFh9DQNLyQ58V0fa2xzRN1iehu0TvX/M1aO91rseME+Ygz5m/JFc+G8onuUaDK/yezqkI9i6qxBHqu7+mBwUW5EIZLCwYd4JYDTGKrgVdO98acVcAjLv8rfKV8/SuODJ1fQafaz6C+O+3W9d5/L/HmCWunYKqDDNp14e8w0IHM2XC4mMYNABHisWkW6fMQ6mZxv2FuiYSITKdIUfFVbpdPOG7GF6jyDb/+LCR4vidNqXAU3ESGVOoyfDOvwm2lS5H7TVvBqEZUSjvIK8rqN5WRAdZ1iolADDoU= ivabus@celerrime"

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
