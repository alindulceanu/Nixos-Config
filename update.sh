#!/usr/bin/env bash

echo "Did you pushed all of your changes? (yes/no)"
read -r CONFIRM

if [ $CONFIRM == "yes" ]; then
  git restore --staged .
  git restore .
  mv hardware-configuration.nix ../
  git pull
  mv ../hardware-configuration.nix .
  git add hardware-configuration.nix
  git apply ~/user-patch.patch
fi
