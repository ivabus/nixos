# NixOS Configuration files.

## Deploying

```shell
nixos-install --flake https://github.com/ivabus/nixos#host
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

## TODO

- do something with dotfiles installation from [ivabus/dotfiles](https://github.com/ivabus/dotfiles)
