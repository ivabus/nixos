{ config, pkgs, ... }:

{
  users.users.ivabus = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      tree
      cargo
      rustc
      neofetch
    ];
    shell = pkgs.zsh;
  };

  programs.zsh = {
    enable = true;
  };

  programs.gnupg.agent.enable = true;
  programs.ssh.startAgent = true;

  programs.git = {
    enable = true;
    userName  = "Ivan Bushchik";
    userEmail = "ivabus@ivabus.dev";
  };
}