{ config, pkgs, lib, ... }:

let cfg = config.my.roles.graphical;
in {
  options.my.roles.graphical.enable = lib.mkEnableOption "Enable GUI (sway)";
  options.my.roles.graphical.basic.enable =
    lib.mkEnableOption "Enable GUI (Plasma 6)";
  config = lib.mkMerge [
    (lib.mkIf (cfg.enable) {
      environment.systemPackages = with pkgs; [
        alacritty
        pavucontrol
        bottom
        glib
        ffmpeg
        cinnamon.nemo
        swayimg
        usbmuxd
        btop
        cava
      ];
      services.gnome.gnome-keyring.enable = true;
      # When adding pkgs prefer GTK over Qt, because Qt bad GTK good

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
          jq
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
          playerctl
        ];
        wrapperFeatures.gtk = true;
      };

      xdg.portal = {
        enable = true;
        wlr.enable = true;
        extraPortals = with pkgs; [
          xdg-desktop-portal-gtk
          xdg-desktop-portal-wlr
        ];
      };

      environment.sessionVariables = {
        NIXOS_OZONE_WL = "1"; # Enable wayland for electron

        XDG_CURRENT_DESKTOP = "sway";
      };
    })
    (lib.mkIf (cfg.enable && config.my.users.ivabus.enable) {
      home-manager.users.ivabus = {
        gtk = {
          enable = true;
          theme = {
            name = "Catppuccin-Macchiato-Standard-Blue-Dark";
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
    })
    (lib.mkIf (cfg.basic.enable) {
      services.xserver.desktopManager.plasma6.enable = true;
      networking.networkmanager.enable = lib.mkForce true;
      networking.networkmanager.wifi.backend = "iwd";
      programs.nm-applet.enable = true;
      services.xserver = {
        displayManager.sddm = {
          enable = true;
          wayland.enable = true;
        };
        enable = true;
        layout = "us,ru";
        xkbOptions = "grp:alt_shift_toggle";
      };
    })
    (lib.mkIf (cfg.basic.enable || cfg.enable) {
      # I should move sound part somewhere else
      sound.enable = true;
      services.pipewire = {
        enable = true;
        alsa.enable = true;
        pulse.enable = true;
        alsa.support32Bit = true;
      };
      /*qt = {
        enable = true;
        platformTheme = "gtk2";
        style = "gtk2";
      };*/

      services.dbus.enable = true;
      environment.systemPackages = with pkgs; [
        (wrapFirefox
          (firefox-unwrapped.override { pipewireSupport = true; }) { })
        libreoffice
      ];
      environment.sessionVariables = { MOZ_USE_XINPUT2 = "1"; };

      fonts.packages = with pkgs; [
        noto-fonts
        noto-fonts-cjk
        noto-fonts-cjk-sans
        noto-fonts-cjk-serif
        noto-fonts-emoji
        jetbrains-mono
        font-awesome
        liberation_ttf
        open-sans
        roboto
        roboto-mono
        kochi-substitute
      ];
    })
  ];
}
