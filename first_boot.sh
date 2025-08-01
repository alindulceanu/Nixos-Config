#!/usr/bin/env bash

# Do not execute with sudo

nix-channel --add https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz home-manager
"$NAME" nix-channel --update
"$NAME" nix-shell '<home-manager>' -A install
cd .. && sudo chown -R "$(whoami)" .dotfiles/
cd .dotfiles || exit

home-manager switch --flake .
