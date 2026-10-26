#!/usr/bin/env bash
# Menu de sessão (substitui o lxsession-logout, que não está instalado).

options="Bloquear\nSuspender\nSair\nReiniciar\nDesligar"

choice=$(echo -e "$options" | rofi -dmenu -i -p "Sessão")

case "$choice" in
  Bloquear)  i3lock -c 000000 ;;
  Suspender) systemctl suspend ;;
  Sair)      bspc quit ;;
  Reiniciar) systemctl reboot ;;
  Desligar)  systemctl poweroff ;;
esac
