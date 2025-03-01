#if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
#	startx
#fi

export QT_QPA_PLATFORMTHEME=gtk3
export XDG_CURRENT_DESKTOP=sway
export XDG_DESKTOP_PLATFORM=sway

