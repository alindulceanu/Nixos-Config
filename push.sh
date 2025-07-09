#!/usr/bin/env bash

git apply --reverse ~/user-patch.patch
mv hardware-configuration.nix ../

git add .

echo "Commit message:"
read -r MESSAGE

git commit -m "${MESSAGE}"
git push --set-upstream origin main:main

git apply ~/user-patch.patch
mv ~/hardware-configuration.nix .
