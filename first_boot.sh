#!/usr/bin/env bash

nix-channel --add https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
ssh-keygen
clear
cat ~/.ssh/id_ed25519.pub
echo "Please add this key to github account"
read -n 1 -s -r -p "Press any key to continue..."

rm -rf ~/.dotfiles
git clone git@github.com:alindulceanu/Nixos-Config.git ~/.dotfiles && cd ~/.dotfiles
git apply ~/user-patch.patch
sudo cp /etc/nixos/hardware-configuration.nix .
home-manager switch --flake .


