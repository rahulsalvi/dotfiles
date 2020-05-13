.PHONY: clang-format picom dunst git gtk i3 jupyter khal kitty latexmk mutt nvim
.PHONY: offlineimap polybar profile pylint ranger redshift rofi tmux ultisnips
.PHONY: update vdirsyncer yapf zathura zsh

clang-format :
	SRC=clang-format DST=.clang-format ./install.sh

dunst :
	m4 dunst/dunstrc.m4 >dunst/dunstrc
	SRC=dunst/dunstrc DST=.config/dunst/dunstrc ./install.sh

git :
	SRC=git/ignore DST=.config/git/ignore ./install.sh

gtk :
	SRC=gtkrc-2.0 DST=.gtkrc-2.0 ./install.sh
	SRC=gtk-3.0/settings.ini DST=.config/gtk-3.0/settings.ini ./install.sh

i3 :
	m4 i3/config.m4 >i3/config
	SRC=i3/config DST=.config/i3/config ./install.sh
	SRC=i3/move_to_new_workspace DST=.config/i3/move_to_new_workspace ./install.sh
	SRC=i3/move_to_next_workspace DST=.config/i3/move_to_next_workspace ./install.sh
	SRC=i3/move_to_prev_workspace DST=.config/i3/move_to_prev_workspace ./install.sh
	SRC=i3/new_workspace DST=.config/i3/new_workspace ./install.sh
	SRC=i3/next_workspace DST=.config/i3/next_workspace ./install.sh
	SRC=i3/prev_workspace DST=.config/i3/prev_workspace ./install.sh

jupyter :
	SRC=jupyter/custom DST=.jupyter/custom ./install.sh
	SRC=jupyter/jupyter_notebook_config.py DST=.jupyter/jupyter_notebook_config.py ./install.sh
	SRC=jupyter/nbconfig DST=.jupyter/nbconfig ./install.sh

khal :
	SRC=khal/config DST=.config/khal/config ./install.sh

kitty :
	SRC=kitty/kitty.conf DST=.config/kitty/kitty.conf ./install.sh
	SRC=kitty DST=.config/kitty/sessions ./install.sh

latexmk :
	SRC=latexmkrc DST=.config/latexmk/latexmkrc ./install.sh

mutt :
	SRC=mutt/mailcap DST=.config/neomutt/mailcap ./install.sh
	SRC=mutt/neomuttrc DST=.config/neomutt/neomuttrc ./install.sh

nvim :
	SRC=nvim/init.vim DST=.config/nvim/init.vim ./install.sh
	SRC=nvim/coc-settings.json DST=.config/nvim/coc-settings.json ./install.sh

offlineimap :
	SRC=offlineimap/offlineimaprc DST=.config/offlineimap/config ./install.sh
	SRC=offlineimap/offlineimap-postsync.sh DST=.config/offlineimap/offlineimap-postsync.sh ./install.sh
	SRC=offlineimap/get_mail_from DST=.config/offlineimap/get_mail_from ./install.sh
	SRC=offlineimap/get_mail_subject DST=.config/offlineimap/get_mail_subject ./install.sh

picom :
	SRC=picom.conf DST=.config/picom.conf ./install.sh

polybar :
	SRC=polybar/config DST=.config/polybar/config ./install.sh
	SRC=polybar/launch.sh DST=.config/polybar/launch.sh ./install.sh
	SRC=polybar/vpn.sh DST=.config/polybar/vpn.sh ./install.sh
	SRC=polybar/mail_sync.sh DST=.config/polybar/mail_sync.sh ./install.sh
	SRC=polybar/calendar_sync.sh DST=.config/polybar/calendar_sync.sh ./install.sh
	SRC=polybar/spotify.sh DST=.config/polybar/spotify.sh ./install.sh
	SRC=polybar/count_unread_mail.py DST=.config/polybar/count_unread_mail.py ./install.sh
	SRC=polybar/unread_mail.sh DST=.config/polybar/unread_mail.sh ./install.sh

profile :
	SRC=profile DST=.profile ./install.sh

pylint :
	SRC=pylintrc DST=.config/pylintrc ./install.sh

ranger :
	SRC=ranger/rc.conf DST=.config/ranger/rc.conf ./install.sh
	SRC=ranger/rifle.conf DST=.config/ranger/rifle.conf ./install.sh

redshift :
	SRC=redshift.conf DST=.config/redshift.conf ./install.sh

rofi :
	SRC=rofi/config DST=.config/rofi/config ./install.sh
	SRC=rofi/apps.sh DST=.config/rofi/apps.sh ./install.sh

tmux :
	SRC=tmux.conf DST=.config/tmux/tmux.conf ./install.sh

ultisnips :
	SRC=ultisnips DST=.config/ultisnips ./install.sh

update :
	SRC=update DST=.local/bin/update ./install.sh

vdirsyncer :
	SRC=vdirsyncer/config DST=.config/vdirsyncer/config ./install.sh

yapf :
	SRC=yapf/style DST=.config/yapf/style ./install.sh

zathura :
	SRC=zathura/zathurarc DST=.config/zathura/zathurarc ./install.sh

zsh :
	SRC=zshrc DST=.zshrc ./install.sh
