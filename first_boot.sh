#!/usr/bin/env bash

nix-channel --add https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
ssh-keygen
clear
cat ~/.ssh/id_ed25519.pub
echo "Please add this key to github account"
read -n 1 -s -r -p "Press any key to continue..."
cd .. && sudo chown -R alin .dotfiles/

git remote remove origin
git remote add origin git@github.com:alin-dulceanu/Nixos-Config.git
git fetch --set-upstream origin main:main

home-manager switch --flake .


