#!/bin/bash
layout=be
user=aluc
home=/home/${user}

useradd -m -G wheel ${user}

ping -c4 archlinux.org \
  || exit 1
pacman --noconfirm -Syu \
  || exit 1

  # npm \
  # jre \
pacman --noconfirm -S \
	neovim \
  lynx nnn python-pygments tmux \
  man-db man-pages bash-completion exa \
  htop \
  fzf \
  pacman-contrib pkgfile\
  python3 python-pip \
  wget yt-dlp \
  zip unzip \
  git openssh \
  pass mutt \
  xmonad xmonad-contrib xmobar picom \
  xclip xdotool xorg-xev xorg-xfd xautolock x11-ssh-askpass \
  dunst libnotify numlockx redshift unclutter \
  alacritty kitty \
  ttf-ubuntu-font-family \
  mpv feh cmus w3m \
  pulseaudio pulseaudio-alsa pulsemixer pamixer \
  inetutils \
  || exit 1

# pacman --noconfirm -S \
#   maim tesseract tesseract-data-eng \
#   evince dolphin \
#   firefox passff-host \

# Theming
pacman --noconfirm -S \
    kvantum lxappearance arc-gtk-theme

pacman --noconfirm -S \
 zsh zsh-syntax-highlighting zsh-autosuggestions starship \
  || exit 1
chsh -s /bin/zsh aluc

# pacman --noconfirm -S \
#     virtualbox virtualbox-guest-iso
# usermod -aG vboxusers "${user}"

# pacman --noconfirm -S \
# virt-manager qemu-desktop libvirt edk2-ovmf dnsmasq iptables-nft
#
# sudo usermod -aG libvirt "${user}"
# echo "unix_sock_rw_perms = '0770'" | sudo tee -a /etc/libvirt/libvirtd.conf
# echo "unix_sock_group = 'libvirt'" | sudo tee -a /etc/libvirt/libvirtd.conf
# echo "user = ${user}"| sudo tee -a /etc/libvirt/qemu.conf
# echo "group = ${user}" | sudo tee -a /etc/libvirt/qemu.conf
# virsh pool-define-as VMs dir - - - - /home/aluc/Media/sdb/VMs

# pacman --noconfirm -S nvidia nvidia-settings nvidia-utils
# # STEAM, careful install!!! libraries & shaders are gpu specific
# pacman --noconfirm -S discord steam lutris
# pacman --noconfirm -S spotifyd
# # Vulkan drivers?
# # Probably won't need to manually install
# pacman --noconfirm -S wine wine-mono
# pacman --noconfirm -S gimp

# # For barrier
# pacman --noconfirm -S \
# barrier pyside2

# # Android shi
# pacman --noconfirm -S \
#     android-tools \
#     usbutils \
#     android-file-transfer \
#     || exit 1

pacman --noconfirm -S xorg-server xorg-xinit

echo "Don't forget to set a password for '${user}'"
echo "Don't forget to edit visudo file"
