## Welcome to my nixos dotfiles

In order to install it you can use a minimal nixos install running this command inside it:

```
nix-shell -p git --run "git clone https://github.com/alindulceanu/nixos-config && sudo bash nixos-config/install.sh"
```

Suffix is when your partitions generate with a letter before the actual number

First thing after boot, you should go to another tty and run first_boot.sh to install home-manager and related software.

Enjoy!
