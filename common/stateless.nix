{ config, lib, ... }:

{
  boot.kernel.sysctl = {
    "vm.panic_on_oom" = true;
    "kernel.panic" = 3;
  };
}
