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

# Calcular la suma de los porcentajes de las dos baterías
total_capacity=$((bat0 + bat1))

# Calcular el número total de baterías (considerando 2)
num_batteries=2

# Calcular el porcentaje promedio real (incluyendo baterías que puedan estar a 0%)
avg_percentage=$((total_capacity / num_batteries))

# Determinar si alguna batería está cargando
charging_symbol=""
if [ "$state0" = "Charging" ] || [ "$state1" = "Charging" ]; then
    charging_symbol=" ⚡"
fi

# Mostrar el resultado entre 0 y 100, con símbolo de carga si aplica
echo "El porcentaje total de la batería es: $avg_percentage%$charging_symbol"

