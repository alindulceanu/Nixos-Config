#!/usr/bin/env bash

# include username when running the script
NAME=$1

sudo -u "$NAME" nix-channel --add https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz home-manager
sudo -u "$NAME" nix-channel --update
sudo -u "$NAME" nix-shell '<home-manager>' -A install
cd .. && sudo chown -R "$NAME" .dotfiles/
cd .dotfiles || exit

sudo -u "$NAME" home-manager switch --flake .
