#!/bin/sh
# Cada monitor tem os mesmos desktops (I..V), assim super + N leva ao
# desktop N do monitor focado (ver sxhkdrc).
#
#   monitors.sh          organiza os desktops uma vez
#   monitors.sh --watch  reorganiza e reinicia o polybar a cada monitor
#                        conectado/desconectado

DESKTOPS="I II III IV V"
COUNT=$(echo $DESKTOPS | wc -w)

setup() {
	for m in $(bspc query -M --names); do
		# Desktops excedentes (ex.: herdados de um monitor desconectado):
		# as janelas vão para o desktop de mesmo número, em vez de o
		# `monitor -d` empilhar todas no desktop focado.
		i=0
		for d in $(bspc query -D -m "$m"); do
			i=$((i + 1))
			[ "$i" -le "$COUNT" ] && continue
			target=$(( (i - 1) % COUNT + 1 ))
			for n in $(bspc query -N -d "$d" -n .window); do
				bspc node "$n" -d "$m:^$target"
			done
		done
		bspc monitor "$m" -d $DESKTOPS
	done
}

setup

if [ "$1" = "--watch" ]; then
	bspc subscribe monitor_add monitor_remove | while read -r _; do
		setup
		"$HOME/.config/polybar/launch.sh"
	done
fi
