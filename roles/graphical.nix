{ config, pkgs, lib, ... }:

let
  cfg = config.my.roles.graphical;
in {
  options.my.roles.graphical.enable = lib.mkEnableOption "Enable GUI";
  config = lib.mkIf (cfg.enable) {
    environment.systemPackages = with pkgs; [
      firefox
      alacritty
      pavucontrol
      bottom
      mpv
      glib
      ffmpeg
      cinnamon.nemo
      usbmuxd
      telegram-desktop
      keepassxc
    ];

    services.greetd = {
      enable = true;
      vt = 7;
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
        libsForQt5.qt5ct
        mako
        brightnessctl
        wdisplays
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
      alsa.support32Bit = true;
      jack.enable = true;
    };

    qt = {
      enable = true;
      platformTheme = "gtk2";
      style = "gtk2";
    };

    services.dbus.enable = true;

    fonts.packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-emoji
      jetbrains-mono
      font-awesome
      #google-fonts
      liberation_ttf
      open-sans
      roboto
      roboto-mono
      kochi-substitute
    ];

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
    };
  };
}