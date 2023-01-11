.PHONY: clang-format
clang-format :
	SRC=clang-format DST=.clang-format ./install.sh

.PHONY: dunst
dunst :
	SRC=dunst/dunstrc DST=.config/dunst/dunstrc ./install.sh

.PHONY: fehbg
fehbg :
	SRC=fehbg DST=.config/fehbg ./install.sh

.PHONY: git
git :
	SRC=git/ignore DST=.config/git/ignore ./install.sh

.PHONY: gtk
gtk :
	SRC=gtkrc-2.0 DST=.gtkrc-2.0 ./install.sh
	SRC=gtk-3.0/settings.ini DST=.config/gtk-3.0/settings.ini ./install.sh

.PHONY: i3
i3 :
	m4 i3/config.m4 >i3/config
	SRC=i3/config DST=.config/i3/config ./install.sh
	SRC=i3/move_to_new_workspace DST=.config/i3/move_to_new_workspace ./install.sh
	SRC=i3/move_to_next_workspace DST=.config/i3/move_to_next_workspace ./install.sh
	SRC=i3/move_to_prev_workspace DST=.config/i3/move_to_prev_workspace ./install.sh
	SRC=i3/new_workspace DST=.config/i3/new_workspace ./install.sh
	SRC=i3/next_workspace DST=.config/i3/next_workspace ./install.sh
	SRC=i3/prev_workspace DST=.config/i3/prev_workspace ./install.sh
	i3-msg 'reload'

.PHONY: khal
khal :
	SRC=khal/config DST=.config/khal/config ./install.sh

.PHONY: kitty
kitty :
	SRC=kitty/kitty.conf DST=.config/kitty/kitty.conf ./install.sh

.PHONY: latexmk
latexmk :
	SRC=latexmkrc DST=.config/latexmk/latexmkrc ./install.sh

.PHONY: lazygit
lazygit :
	SRC=lazygit/config.yml DST=.config/lazygit/config.yml ./install.sh

.PHONY: nvim
nvim :
	SRC=nvim/init.vim DST=.config/nvim/init.vim ./install.sh

.PHONY: offlineimap
offlineimap :
	SRC=offlineimap/offlineimap-postsync.sh DST=.config/offlineimap/offlineimap-postsync.sh ./install.sh
	SRC=offlineimap/get_mail_from DST=.config/offlineimap/get_mail_from ./install.sh
	SRC=offlineimap/get_mail_subject DST=.config/offlineimap/get_mail_subject ./install.sh

.PHONY: picom
picom :
	SRC=picom.conf DST=.config/picom.conf ./install.sh

.PHONY: polybar
polybar :
	SRC=polybar/config.ini DST=.config/polybar/config.ini ./install.sh
	SRC=polybar/launch.sh DST=.config/polybar/launch.sh ./install.sh
	SRC=polybar/audio.sh DST=.config/polybar/audio.sh ./install.sh
	SRC=polybar/vpn.sh DST=.config/polybar/vpn.sh ./install.sh
	SRC=polybar/mail_sync.sh DST=.config/polybar/mail_sync.sh ./install.sh
	SRC=polybar/calendar_sync.sh DST=.config/polybar/calendar_sync.sh ./install.sh
	SRC=polybar/spotify.sh DST=.config/polybar/spotify.sh ./install.sh
	SRC=polybar/count_unread_mail.py DST=.config/polybar/count_unread_mail.py ./install.sh
	SRC=polybar/unread_mail.sh DST=.config/polybar/unread_mail.sh ./install.sh

.PHONY: profile
profile :
	SRC=profile DST=.profile ./install.sh

.PHONY: pylint
pylint :
	SRC=pylintrc DST=.config/pylintrc ./install.sh

.PHONY: ranger
ranger :
	SRC=ranger/rc.conf DST=.config/ranger/rc.conf ./install.sh
	SRC=ranger/rifle.conf DST=.config/ranger/rifle.conf ./install.sh

.PHONY: rofi
rofi :
	SRC=rofi/config.rasi DST=.config/rofi/config.rasi ./install.sh
	SRC=rofi/apps.sh DST=.config/rofi/apps.sh ./install.sh

.PHONY: sway
sway :
	SRC=sway/config DST=.config/sway/config ./install.sh
	SRC=sway/$(shell hostname)-apps DST=.config/sway/config.d/$(shell hostname)-apps ./install.sh
	SRC=sway/$(shell hostname)-io DST=.config/sway/config.d/$(shell hostname)-io ./install.sh
	SRC=sway/$(shell hostname)-idle DST=.config/swayidle/config ./install.sh
	SRC=sway/lock DST=.config/swaylock/config ./install.sh
	SRC=sway/nag DST=.config/swaynag/config ./install.sh
	SRC=sway/move_to_new_workspace DST=.config/sway/move_to_new_workspace ./install.sh
	SRC=sway/move_to_next_workspace DST=.config/sway/move_to_next_workspace ./install.sh
	SRC=sway/move_to_prev_workspace DST=.config/sway/move_to_prev_workspace ./install.sh
	SRC=sway/new_workspace DST=.config/sway/new_workspace ./install.sh
	SRC=sway/next_workspace DST=.config/sway/next_workspace ./install.sh
	SRC=sway/prev_workspace DST=.config/sway/prev_workspace ./install.sh

.PHONY: tablet
tablet :
	SRC=tablet/init_xsetwacom DST=.config/tablet/init_xsetwacom ./install.sh

.PHONY: tmux
tmux :
	SRC=tmux.conf DST=.config/tmux/tmux.conf ./install.sh

.PHONY: ultisnips
ultisnips :
	SRC=ultisnips DST=.config/ultisnips ./install.sh

.PHONY: update
update :
	SRC=update DST=.local/bin/update ./install.sh

.PHONY: vdirsyncer
vdirsyncer :
	SRC=vdirsyncer/config DST=.config/vdirsyncer/config ./install.sh

.PHONY: waybar
waybar :
	SRC=waybar/config DST=.config/waybar/config ./install.sh
	SRC=waybar/style.css DST=.config/waybar/style.css ./install.sh
	SRC=waybar/audio.sh DST=.config/waybar/audio.sh ./install.sh
	SRC=waybar/unread_mail.sh DST=.config/waybar/unread_mail.sh ./install.sh
	SRC=waybar/count_unread_mail.py DST=.config/waybar/count_unread_mail.py ./install.sh
	SRC=waybar/spotify.sh DST=.config/waybar/spotify.sh ./install.sh

.PHONY: yapf
yapf :
	SRC=yapf/style DST=.config/yapf/style ./install.sh

.PHONY: zathura
zathura :
	SRC=zathura/zathurarc DST=.config/zathura/zathurarc ./install.sh

.PHONY: zsh
zsh :
	SRC=zshrc DST=.zshrc ./install.sh
