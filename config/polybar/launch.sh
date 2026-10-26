#!/usr/bin/env bash

THEME="onedark"

CONFIG=$(dirname "$(readlink -f "$0")")/themes/$THEME/config.ini

killall -q polybar
while pgrep -u "$UID" -x polybar >/dev/null; do sleep 0.2; done

# Uma barra por monitor conectado. O monitor primário usa bar/main (com o
# tray); os demais usam bar/secondary, já que só pode existir um tray.
MONITORS=$(polybar --list-monitors | cut -d: -f1)
PRIMARY=$(polybar --list-monitors | awk -F: '/primary/ {print $1; exit}')
PRIMARY=${PRIMARY:-$(echo "$MONITORS" | head -n1)}

for m in $MONITORS; do
  bar=secondary
  [ "$m" = "$PRIMARY" ] && bar=main
  MONITOR=$m polybar -q -r "$bar" -c "$CONFIG" &
done
