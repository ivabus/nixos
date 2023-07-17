{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    firefox
    alacritty
    pavucontrol
    bottom
    mpv
    glib
    ffmpeg
    cinnamon.mint-y-icons
    usbmuxd
  ];
  services.fwupd.enable = true;
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd sway";
        user = "greeter";
      };
    };
  };
  programs.sway = {
    enable = true;
    extraPackages = with pkgs; [
      waybar
      grim
      slurp
      wf-recorder
      sway-launcher-desktop
      swaybg
      swayidle
      swaylock
      poweralertd
      kanshi
      catppuccin-cursors
      libsForQt5.qt5ct
      mako
      pulseaudio
      brightnessctl
    ];
    wrapperFeatures.gtk = true;
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  services.dbus.enable = true;

  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    jetbrains-mono
  ];
}