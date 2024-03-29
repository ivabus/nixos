# ivabus NixOS Configuration files.

## Deploying

Setup disks, mount root to `/mnt` and `/boot` to `/mnt/boot` and run something like this

```
git clone https://github.com/ivabus/nixos /mnt/etc/nixos
nixos-generate-config --show-hardware-config --root /mnt > /mnt/etc/nixos/machines/HOST/hardware.nix
nixos-install --flake path:.#HOST
```

### Raspberry Pi image generation

Replace `{{REPO_PATH}}` with path to this repo (surprising, isn't it) and run on NixOS system (or system with Nix (don't tested))

```
nix build path:{{REPO_PATH}}#nixosConfigurations.HOST.config.system.build.sdImage
```

## Rebuilding

```shell
nixos-rebuild switch --flake path:/etc/nixos
```

Apple Silicon hosts require additional `--impure` flag for firmware installation. (Firmware should be placed in `/etc/nixos/asahi/firmware` (ignored by git) and m1n1 icon to `/etc/nixos/asahi/icon.png` (256x256px)).

### Hosts configured

- celerrime (MacBook Air M2) (coding)
- vetus (iMac 27" 2017) (gaming)
- stella (Random Ryzen 3 3250U laptop) (lite web surfing client)
- rubusidaeus (Raspberry Pi 4B) (small services)
- periculo (StarFive VisionFive2) (as router) - WIP + untested

## Modules

Module example:

```nix
{ config, lib, ... }:

let
  cfg = config.my.MODULE;
in {
  options.my.MODULE.enable = lib.mkEnableOption "Enable MODULE";
  config = lib.mkIf (cfg.enable) {
    MODULE_CONFIGURATION
  };
}
```

## Dotfiles development

As I fully manage my dotfiles through home-manager and `fetchGit` they are readonly.

To install normal version of them disable `my.users.ivabus.dotfiles.enable` and run this command (which installs and links dotfiles)

```
curl https://iva.bz/nix | sh
```

## TODO

- Setup "secret" roles (I need them)
- Setup router (in progress with `periculo`, aughhhhhhhhh it seems like I need to crosscompile it for 30 days straight, so no fast progress)

## Copyright

This configuration is [MIT licensed](./LICENSE).

I used [delroth/infra.delroth.net](https://github.com/delroth/infra.delroth.net) (MIT license) as a reference for my configuration.

