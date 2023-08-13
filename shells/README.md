# Shells

- `crossShell.nix` - Just useful shell for cross compiling

## Using

```
nix-shell PATH_TO_SHELL
```

### `crossShell.nix`

By default configured for `aarch64-unknown-linux-musl`, but target may be replaced by adding crossSystem arg, like `--argstr crossSystem "x86_64-unknown-linux-musl"`.
