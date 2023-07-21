#!/bin/bash

# Variables for disk and encryption setup
disk="/dev/sda"
luks_passphrase="your_luks_passphrase"
hostname="your_hostname"
username="your_username"
user_password="your_user_password"
root_password="your_root_password"

# Verify boot in UEFI or BIOS/CSM (Legacy) mode
if [ -d /sys/firmware/efi/efivars ]; then
  echo "UEFI mode detected."
else
  echo "Legacy mode detected."
  exit 1
fi

# Configuração do idioma e fuso horário
echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
export LANG=en_US.UTF-8
ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
hwclock --systohc

# Internet connection check
ping -c 3 www.google.com
if [ $? -eq 0 ]; then
  echo "Internet connection established."
else
  echo "No internet connection. Check the connection and try again."
  exit 1
fi


