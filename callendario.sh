#!/bin/bash

# Obtener el mes y año actuales (puedes personalizar esto)
mes=$(date +"%m")
axo=$(date +"%Y")

# Generar el calendario
calendario=$(cal)

# Enviar la notificación
notify-send -t 10000 "Calendario de $mes/$axo" "$calendario"
