#!/usr/bin/env bash
set -euo pipefail

REPO_URL="https://github.com/alindulceanu/nixos-config"
SCRIPT_DIR=".dotfiles"
MOUNT_POINT="/mnt"

echo "Welcome to my nixos installer!"

lsblk
echo "Enter target disk"
read -r DISK

echo "This erases ALL data from drive, are you sure? (yes/no)"
read -r CONFIRM

if [ "$CONFIRM" != "yes" ]; then
  echo "Aborting..."
  exit 1
fi

echo "Partitioning Disk"
sudo parted --script "$DISK" \
  mklabel gpt \
  mkpart ESP fat32 1MiB 512MiB \
  set 1 esp on \
  mkpart primary ext4 512MiB 100% \
  # mkpart primary ext4 100GiB 100%

EFI_PART="${DISK}1"
ROOT_PART="${DISK}2"
#HOME_PART="${DISK}3"

echo "Formatting partitions!"
mkfs.fat -F32 "${EFI_PART}"
mkfs.ext4 -F "${ROOT_PART}"
#mkfs.ext4 -F "${HOME_PART}"

echo "Mounting partitions"
sudo mount "${ROOT_PART}" "${MOUNT_POINT}"
mkdir -p "${MOUNT_POINT}/boot"
mkdir -p "${MOUNT_POINT}/home"
sudo mount "${EFI_PART}" "${MOUNT_POINT}/boot"
#sudo mount "${HOME_PART}" "${MOUNT_POINT}/home"

echo "Enter Hostname"
read -r HOSTNAME

echo "Enter Username"
read -r USERNAME
mkdir -p "$MOUNT_POINT/home/$USERNAME/$SCRIPT_DIR"

echo "Pulling configurations"
git clone "${REPO_URL}" "${MOUNT_POINT}/home/${USERNAME}/${SCRIPT_DIR}"

echo "Generating hardware config"
nixos-generate-config --root "${MOUNT_POINT}"
cp "$MOUNT_POINT/etc/nixos/hardware-configuration.nix" "$MOUNT_POINT/home/$USERNAME/$SCRIPT_DIR"

sed -i "s/hostname = \".*\";/hostname = \"$HOSTNAME\";/" "$MOUNT_POINT/home/$USERNAME/$SCRIPT_DIR/flake.nix"
sed -i "s/username = \".*\";/username = \"$USERNAME\";/" "$MOUNT_POINT/home/$USERNAME/$SCRIPT_DIR/flake.nix"

if [ -z "$EDITOR" ]; then
  EDITOR=nano;
fi

$EDITOR $MOUNT_POINT/home/$USERNAME/$SCRIPT_DIR/flake.nix

echo "Building the flake"
nixos-rebuild switch --flake "$MOUNT_POINT/home/$USERNAME/$SCRIPT_DIR" --root "$MOUNT_POINT"

echo "Installing home-manager and building the home config"
nixos-enter --root "$MOUNT_POINT" -- \
  sudo -u "$USERNAME" nix run github:nix-community/home-manager/release-25.05 \
  --extra-experimental-features nix-command \
  --extra-experimental-features flakes \
  -- switch --flake "/home/$USERNAME/$SCRIPT_DIR"
