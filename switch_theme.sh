#!/bin/bash

CONFIG=~/.config/gtk-3.0/settings.ini

if grep -q "gtk-theme-name=Breeze-Dark" "$CONFIG"; then
    sed -i 's/Breeze-Dark/Breeze/' "$CONFIG"
	gsettings set org.gnome.desktop.interface gtk-theme "Breeze"
	gsettings set org.gnome.desktop.interface gtk4-theme "Breeze"
	gsettings set org.gnome.desktop.interface icon-theme "Papirus"
    gsettings set org.gnome.desktop.interface color-scheme "prefer-light"
else
    sed -i 's/Breeze/Breeze-Dark/' "$CONFIG"
	gsettings set org.gnome.desktop.interface gtk-theme "Breeze-Dark"
	gsettings set org.gnome.desktop.interface gtk4-theme "Breeze-Dark"
	gsettings set org.gnome.desktop.interface icon-theme "Papirus-Dark"
    gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
fi

