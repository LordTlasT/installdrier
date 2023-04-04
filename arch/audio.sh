#!/usr/bin/env sh
case "${IND_SERVER:-pulse}" in
	"pulse")
		pacman --noconfirm -S \
			pulseaudio pulseaudio-alsa pulsemixer pamixer \
			spotifyd
		;;
	"pipewire")
		pacman --noconfirm -S \
			pipewire wireplumber \
			pipewire-pulse pipewire-alsa
		# noisetorch ? easyeffects?
		;;
	*)
		echo "no server?"
esac
