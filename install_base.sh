#!/bin/bash
sudo pacman -Syu --needed git base-devel archlinux-keyring
sudo pacman -Syyu xdg-desktop-portal-wlr xdg-desktop-portal-gtk godot blender gimp inkscape audacity neovim gcc clang zig cmake chromium thunar vlc filelight tree-sitter tree-sitter-cli gwenview poedit steam prismlauncher alacritty fzf ripgrep-all fd btop fastfetch yt-dlp scrcpy lazygit qmk keyd ly i3-wm i3lock i3status dmenu picom dunst flameshot sway swayidle swaylock waybar wofi wmenu grim slurp wl-clipboard pipewire pavucontrol pasystray fcitx5 fcitx5-mozc fcitx5-configtool rust vlc-plugins-all libdvdcss adobe-source-han-sans-jp-fonts adobe-source-han-serif-jp-fonts noto-fonts adobe-source-han-sans-cn-fonts adobe-source-han-sans-kr-fonts ttf-jetbrains-mono-nerd ttf-hack adobe-source-code-pro-fonts ttf-jetbrains-mono noto-fonts-emoji ttf-liberation gnu-free-fonts zls gvfs thunar-volman thunar-archive-plugin
fc-cache -fv

rm -rf yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd
yay -Syu gozen-bin aseprite obs-studio-git


# Homerow script in  /etc/keyd/default.conf
# [ids]
#
# *
#
# [main]
#
# f = overload(shift, f)
# j = overload(shift, j)
