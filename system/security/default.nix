{ ... }:
{
  imports = [
    ./gpg.nix
    ./sshd.nix
    ./firewall.nix
    ./automount.nix
  ];
}
