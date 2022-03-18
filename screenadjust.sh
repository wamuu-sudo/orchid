#!/bin/bash
echo "Ajustement de écrans conformément au paramètrage inital."
xrandr --output DisplayPort-0 --mode 2560x1440 --rate 143.86 && xrandr --output HDMI-A-0 --mode 1920x1080 --rate 71.91
echo "Configuration à jour."
