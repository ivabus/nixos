# NixOS Configuration files.

## Deploying

Setup disks, mount root to `/mnt` and `/boot` to `/mnt/boot` and run something like it

```shell
git clone https://github.com/ivabus/nixos /mnt/etc/nixos
nixos-generate-config --show-hardware-config --root /mnt > /mnt/etc/nixos/machines/host/hardware.nix
nixos-install --flake path:.#host
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

## Dotfiles (from `ivabus/dotfiles`)

I'm installing my dotfiles using (with prepared script)

```shell
curl https://iva.bz/nix | sh
```
