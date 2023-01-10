#!/usr/bin/env bash

pacman --noconfirm -S nvidia nvidia-settings nvidia-utils
# STEAM, careful install!!! libraries & shaders are gpu specific
pacman --noconfirm -S wine wine-mono
pacman --noconfirm -S steam lutris
