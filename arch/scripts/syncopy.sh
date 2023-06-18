#!/bin/sh

syncp="$HOME/sync"
syncs="$syncp/sysfiles/"

# patching
doas sh -c "patch -p 1 /usr/share/X11/xkb/symbols/us < $syncs/keymap.diff"
patch -p 1 $HOME/.local/share/nvim/site/pack/packer/start/nord.nvim/lua/nord/theme.lua \
	< $syncs/nordnvim.diff

# linking
ln -sf $syncp/nb_urls $HOME/.config/newsboat/

# copying
doas mkdir /etc/pacman.d/hooks
doas cp $syncs/zsh.hook /etc/pacman.d/hooks/
doas cp $syncs/disable-turbo-boost.service /etc/systemd/system/
doas systemctl daemon-reload
doas systemctl enable --now disable-turbo-boost.service
