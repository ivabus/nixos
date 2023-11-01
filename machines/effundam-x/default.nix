{ pkgs, home, lib, ... }: {
  # Cannot use "my" for a while. Need to adapt it not to be linux-only
  imports = [ ../../common/base.nix ];

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    neofetch
  ];

  security.pam.enableSudoTouchIdAuth = true;

  networking = {
    hostName = "effundam-x"; # ugly
    computerName = "effundam on X"; # pretty
  };

  /*
  services.navidrome = {
    enable = true;
    settings = {
      Port = 4544;
      Address = "0.0.0.0";
      MusicFolder = "/Users/ivabus/Music";
    };
  };*/

  environment.shells = with pkgs; [ zsh ];
  programs.zsh = {
    enable = true;
    promptInit = "";
  };
  users.users.ivabus.home = "/Users/ivabus";
  users.users.ivabus.openssh.authorizedKeys.keys = [
    # i should somehow reuse it from common/user.nix
    # celerrime-x
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC6HY6er37FUz2tPQnwq5SUQZ5KHmMpGQA5yNlxPOyoCV+uvdx/cU8KF7jlFoyBC9xf2FvNyB8H1MZ6t2eUs4m/pVMpoBbNSTZLSxlvv2n4HuxL2Sg3qPdioJOyxDfnXA4OIZ+Tc+z4zM3ZnPJm1ccGW7W+YPhZ7GhBpl5wlMw+m06dCt8wfdDA4fuf4brnLt1ZMs4aOtVM8u4ZEtMs3IVXVUgtRH5m0RXZ94s7RkrUHhl2UOkOclhkQOiQop9RuJMjpi+iYkDYCniuGCKcKPrmi1+qicKM8KyrYGqR7FkUvzr+H8XtJXu++Kvmjcn54jDYqM4sq/MNL2rf8QaIUGLwiq2ljH2dGamElvElWZoXQBGPp4L80IEbaMVISIcvcNj+8cKW3rPvEUK5iT8jCkIOUwm1oo70YawS5VXTPLDsZif12QduTcJhVJekEaP0ZSifO52zeJksj0adwiEMJPqm7bIk5Y+9dCbQH7PtkWY4Tw3bdGNsYnTXC80MeEfrIKE="

    # Stella
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDXWPxd1uVVxEARVezy0s0LZ9fC/Mif6s218oNWDyJNqZMnAiaMwwP/mGHqCy1OXFCb8/5Kv3AM+z6sxY4mIvyXhx3lPW841HoOlJxR+JQ50qgxon/oCXjKFVMZjFptRtexgQLhubhjyINagj7T/K6UjsfC9sIG5DUJdem0O8ZD/8EqvIrkeNGP52klJM3sR4vhXMNwOIPkukNOMq+OLXgAaCXRImc53N+Whi/tCaxxr/Nen5CVGo9raAekRKaiBLKvgboXYnxzNFxiecUe7mqPbyE2bcnJ+rDC7UlwrNYGyIQ/8POjQwbanFxT4UJhS5ib6/hSpia0eYaSiutBqU3fQcIXrmTQWOrGPdrUsLHw5xGMfwnPmoDFMYHdcchU0v6QijbrHrsqVV/bikWoQF4JT7PCwOejfVowOioPghvW2u34gTyMKPkueaMk0w8Jq45V0meneyN5SbobqZX3XFze4Uz3BN8nuiZB6pFRPv0eKLqEqX8+nST9uQDBkqKTvwE= ivabus@stella"

    # Celerrime
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCgZJjP2BRycxcR53sriaityzT24f+umMO8iz/xUvWRUJpgwA4WJyqgKwxuIhKYPUZ7e3H/vVPrt3ZqAaqoFM7OildtcXyRskwinuAxE6lhOEE69s1M3iqCXbrTM9YluMlrvf7yd4edInH0jdlCTwuZOY+yisrGU+nOpSSuJgcwlme2fv1pQtKgTQpqz1GflIaXm5415Do4okanNlfuAJXix7ic0PkaLN0gTtONqwJR1W3hkF8hnlHV49t8QvrJHgQptbVdDgd9f96+a6OL6y/6rixnEU23yuC29lWxSwrixwC0xY+/CjhMlDzXqvePG55vC4K5UQypKcvMOCLV/0z9s5m0ca5mvS9eqPDcUj2+9r7VFaL0IdZl4i7eG9JJSS4h/22Or7CdU9Dv0kiMYP3HLiihjS/lrQVEEYpEMr3DmhSnij5DeGZFmMRM2UN5ZqR7/QhkslhQg340ik6ZENjpxuQ9rQino5XRK52DoUiLHleKI/ibBHQ4LiREvX9muyM= ivabus@celerrime"
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  services.nix-daemon.enable = true;
}
