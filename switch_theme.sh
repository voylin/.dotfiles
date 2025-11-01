#!/bin/bash

GTK3_CONFIG="$HOME/.config/gtk-3.0/settings.ini"
GTK4_CONFIG="$HOME/.config/gtk-4.0/settings.ini"

# Get current theme
current=$(gsettings get org.gnome.desktop.interface gtk-theme | tr -d "'")

if [[ "$current" == "Breeze-Dark" ]]; then
    new="Breeze"
    icon="Papirus"
    color="prefer-light"
else
    new="Breeze-Dark"
    icon="Papirus-Dark"
    color="prefer-dark"
fi

# Apply to gsettings
gsettings set org.gnome.desktop.interface gtk-theme "$new"
gsettings set org.gnome.desktop.interface icon-theme "$icon"
gsettings set org.gnome.desktop.interface color-scheme "$color"

# Sync to GTK config files (for apps not respecting gsettings)
for cfg in "$GTK3_CONFIG" "$GTK4_CONFIG"; do
    if [[ -f "$cfg" ]]; then
        sed -i "s/^gtk-theme-name=.*/gtk-theme-name=$new/" "$cfg"
        sed -i "s/^gtk-icon-theme-name=.*/gtk-icon-theme-name=$icon/" "$cfg"
    fi
done
