#!/usr/bin/env bash

echo "Did you pushed all of your changes? (yes/no)"
read -r CONFIRM

if [ $CONFIRM == "yes" ]; then
  git restore .
  git pull
  git apply ~/user-patch.patch
fi
