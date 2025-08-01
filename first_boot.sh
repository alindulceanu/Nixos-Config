#!/usr/bin/env bash

NAME=whoami

nix-channel --add https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
cd .. && sudo chown -R "$NAME" .dotfiles/
cd .dotfiles || exit

home-manager switch --flake .


