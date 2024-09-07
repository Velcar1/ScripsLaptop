#!/bin/bash

# Leer el porcentaje y estado de la batería BAT0
if [ -f /sys/class/power_supply/BAT0/capacity ]; then
    bat0=$(cat /sys/class/power_supply/BAT0/capacity)
    state0=$(cat /sys/class/power_supply/BAT0/status)
else
    bat0=0
    state0="Unknown"
fi

# Leer el porcentaje y estado de la batería BAT1
if [ -f /sys/class/power_supply/BAT1/capacity ]; then
    bat1=$(cat /sys/class/power_supply/BAT1/capacity)
    state1=$(cat /sys/class/power_supply/BAT1/status)
else
    bat1=0
    state1="Unknown"
fi

# Calcular el promedio de las dos baterías
total_batteries=0
total_percentage=0

if [ "$bat0" -gt 0 ]; then
    total_batteries=$((total_batteries + 1))
    total_percentage=$((total_percentage + bat0))
fi

if [ "$bat1" -gt 0 ]; then
    total_batteries=$((total_batteries + 1))
    total_percentage=$((total_percentage + bat1))
fi

# Evitar división por cero
if [ "$total_batteries" -gt 0 ]; then
    avg_percentage=$((total_percentage / total_batteries))
else
    avg_percentage=0
fi

# Determinar si alguna batería está cargando
charging_symbol=""
if [ "$state0" = "Charging" ] || [ "$state1" = "Charging" ]; then
    charging_symbol=" ⚡"
fi

# Mostrar el resultado entre 0 y 100, con símbolo de carga si aplica
echo "   $avg_percentage%$charging_symbol"

# Enviar notificación si el promedio de batería es menor al 10%
if [ "$avg_percentage" -lt 10 ]; then
    notify-send "Advertencia de batería baja" "La batería está por debajo del 10% ($avg_percentage%)"
fi
