# NixOS Configuration files.

## Deploying

Setup disks, mount root to `/mnt` and `/boot` to `/mnt/boot` and run something like this

```shell
git clone https://github.com/ivabus/nixos /mnt/etc/nixos
nixos-generate-config --show-hardware-config --root /mnt > /mnt/etc/nixos/machines/host/hardware.nix
nixos-install --flake path:.#host
```

### Raspberry Pi image generation

Replace `{{REPO_PATH}}` with path to this repo (surprising, isn't it) and run on NixOS system (or system with Nix (don't tested))

```bash
nix build path:{{REPO_PATH}}#nixosConfigurations.HOST.config.system.build.sdImage
```

## Rebuilding

```shell
nixos-rebuild switch --flake path:/etc/nixos
```

Apple Silicon hosts require additional `--impure` flag for firmware installation. (Firmware should be placed in /etc/nixos/asahi/firmware (ignored by git)).

### Hosts configured

- stella (Random Ryzen 3 3250U laptop)
- vetus (iMac 27" 2017)
- celerrime (MacBook Air M2)
- rubusidaeus (Raspberry Pi 4B)

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

## Shells

I "made" some shell in [shells/](./shells).

## Dotfiles (from `ivabus/dotfiles`)

I install my dotfiles with prepared script

```shell
curl https://iva.bz/nix | sh
```

## TODO

- Setup services (which I host)
  - [x] ivabus.dev
  - [ ] iva.bz
  - [ ] ивабус.рф
- Setup "secret" roles (I need them)
- Setup router

## Copyright

This configuration is [MIT licensed](./LICENSE).

I used [delroth/infra.delroth.net](https://github.com/delroth/infra.delroth.net) (MIT license) as a reference for my configuration.

