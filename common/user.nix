{ config, pkgs, lib, secrets, home-manager, ... }:

let
  cfg = config.my.users;
  keys = [
    # celerrime-x
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC6HY6er37FUz2tPQnwq5SUQZ5KHmMpGQA5yNlxPOyoCV+uvdx/cU8KF7jlFoyBC9xf2FvNyB8H1MZ6t2eUs4m/pVMpoBbNSTZLSxlvv2n4HuxL2Sg3qPdioJOyxDfnXA4OIZ+Tc+z4zM3ZnPJm1ccGW7W+YPhZ7GhBpl5wlMw+m06dCt8wfdDA4fuf4brnLt1ZMs4aOtVM8u4ZEtMs3IVXVUgtRH5m0RXZ94s7RkrUHhl2UOkOclhkQOiQop9RuJMjpi+iYkDYCniuGCKcKPrmi1+qicKM8KyrYGqR7FkUvzr+H8XtJXu++Kvmjcn54jDYqM4sq/MNL2rf8QaIUGLwiq2ljH2dGamElvElWZoXQBGPp4L80IEbaMVISIcvcNj+8cKW3rPvEUK5iT8jCkIOUwm1oo70YawS5VXTPLDsZif12QduTcJhVJekEaP0ZSifO52zeJksj0adwiEMJPqm7bIk5Y+9dCbQH7PtkWY4Tw3bdGNsYnTXC80MeEfrIKE= ivabus@celerrime-x"

    # Celerrime
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCgZJjP2BRycxcR53sriaityzT24f+umMO8iz/xUvWRUJpgwA4WJyqgKwxuIhKYPUZ7e3H/vVPrt3ZqAaqoFM7OildtcXyRskwinuAxE6lhOEE69s1M3iqCXbrTM9YluMlrvf7yd4edInH0jdlCTwuZOY+yisrGU+nOpSSuJgcwlme2fv1pQtKgTQpqz1GflIaXm5415Do4okanNlfuAJXix7ic0PkaLN0gTtONqwJR1W3hkF8hnlHV49t8QvrJHgQptbVdDgd9f96+a6OL6y/6rixnEU23yuC29lWxSwrixwC0xY+/CjhMlDzXqvePG55vC4K5UQypKcvMOCLV/0z9s5m0ca5mvS9eqPDcUj2+9r7VFaL0IdZl4i7eG9JJSS4h/22Or7CdU9Dv0kiMYP3HLiihjS/lrQVEEYpEMr3DmhSnij5DeGZFmMRM2UN5ZqR7/QhkslhQg340ik6ZENjpxuQ9rQino5XRK52DoUiLHleKI/ibBHQ4LiREvX9muyM= ivabus@celerrime"
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
