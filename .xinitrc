if [ -d $xinitdir/xinitrc.d ] ; then
 for f in "$xinitdir/xinitrc.d"/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

XDG_MENU_PREFIX=arch- kbuildsycoca6
[[ -f ~/.xprofile ]] && source ~/.xprofile
[[ -f ~/.profile ]] && source ~/.profile
exec i3
