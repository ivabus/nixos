
let
  canaryHash = builtins.hashFile "sha256" ./secrets/canary;
  expectedHash = "bc6f38a927602241c5e0996b61ebd3a90d5356ca76dc968ec14df3cd45c6612c";
in
  if canaryHash != expectedHash then abort "Secrets are not readable. Have you run `git-crypt unlock`?"
  else {
    hashed-password = builtins.readFile ./secrets/hashed-password;
  }