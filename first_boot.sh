#!/usr/bin/env bash

NAME=$(whoami)

sudo -u "$NAME" nix-channel --add https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz home-manager
sudo -u "$NAME" nix-channel --update
sudo -u "$NAME" nix-shell '<home-manager>' -A install
cd .. && sudo chown -R "$NAME" .dotfiles/
cd .dotfiles || exit

sudo -u "$NAME" home-manager switch --flake .


