#!/usr/bin/env bash
set -euo pipefail

REPO_URL="https://github.com/alindulceanu/nixos-config"
SCRIPT_DIR=".dotfiles"
MOUNT_POINT="/mnt"

echo "Welcome to my nixos installer!"

sleep 1

clear
lsblk
echo "Enter target disk"
read -r DISK

clear
echo "Separate home partition? (yes/no)"
read -r HOME_PART_CONFIRM

clear
echo "This erases ALL data from drive, are you sure? (yes/no)"
read -r CONFIRM

if [ "$CONFIRM" != "yes" ]; then
  echo "Aborting..."
  exit 1
fi

clear
echo "Partitioning Disk"
parted --script "/dev/$DISK" \
  mklabel gpt \
  mkpart ESP fat32 1MiB 512MiB \
  set 1 esp on

sleep 2
partprobe "/dev/$DISK" || true
udevadm settle

if [ $HOME_PART_CONFIRM == "yes" ]; then
  parted --script "/dev/$DISK" \
    mkpart primary ext4 512MiB 100GiB \
    mkpart primary ext4 100GiB 100%
  HOME_PART="/dev/${DISK}3"
  mkfs.ext4 -F "$HOME_PART"
else
  parted --script "/dev/$DISK" \
    mkpart primary ext4 512MiB 100%
fi

EFI_PART="/dev/${DISK}1"
ROOT_PART="/dev/${DISK}2"

echo "Formatting partitions!"
mkfs.fat -F32 "${EFI_PART}"
parted "/dev/$DISK" name 1 esp
mkfs.ext4 -F "${ROOT_PART}"

clear
echo "Mounting partitions"
mount "${ROOT_PART}" "${MOUNT_POINT}"
mkdir -p "${MOUNT_POINT}/boot"
mkdir -p "${MOUNT_POINT}/home"
mount "${EFI_PART}" "${MOUNT_POINT}/boot"

if [ $HOME_PART_CONFIRM == "yes" ]; then
  mount "${HOME_PART}" "${MOUNT_POINT}/home"
fi

clear
echo "Enter Hostname"
read -r HOSTNAME

clear
echo "Enter Username"
read -r USERNAME
mkdir -p "$MOUNT_POINT/home/$USERNAME/$SCRIPT_DIR"
sed -i "s/hostname = \".*\";/hostname = \"$HOSTNAME\";/" "nixos-config/flake.nix"
sed -i "s/username = \".*\";/username = \"$USERNAME\";/" "nixos-config/flake.nix"

cd nixos-config
git diff > user-patch.patch
cd ../

clear
echo "Pulling configurations"
cp -r ./nixos-config/. "$MOUNT_POINT/home/$USERNAME/$SCRIPT_DIR"
mv "$MOUNT_POINT/home/$USERNAME/$SCRIPT_DIR/user-patch.patch" "$MOUNT_POINT/home/$USERNAME/"

clear
echo "Generating hardware config"
nixos-generate-config --root "${MOUNT_POINT}"
cp "$MOUNT_POINT/etc/nixos/hardware-configuration.nix" "$MOUNT_POINT/home/$USERNAME/$SCRIPT_DIR"
cd "$MOUNT_POINT/home/$USERNAME/$SCRIPT_DIR"
git add .


clear
echo "Building the flake"
nixos-install --root /mnt --flake "/$MOUNT_POINT/home/$USERNAME/$SCRIPT_DIR#$USERNAME"

clear
echo "Enter password for user $USERNAME"
nixos-enter --root /mnt -- /run/current-system/sw/bin/passwd $USERNAME

clear
echo "Rebooting system"
sleep 5
reboot

