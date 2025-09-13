#!/bin/bash
#Script to change Hyprland's theme, called by a .desktop
/bin/gawk -i inplace -v theme="IMPORTED = $1" '
$0 gsub(/IMPORTED = .*/, theme)
' ~/.config/hypr/var.conf
~/.config/hypr/scripts/Restart_Steam.sh
~/.config/hypr/scripts/Restart_Spotify.sh
