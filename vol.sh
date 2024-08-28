#!/bin/sh

# Obtener el estado de volumen y mostrar el resultado

case $BUTTON in
    1) exec ~/scripts/./wifi_red.sh ;;
    4) exec ~/scripts/./wifi_devices.sh ;;
esac


volume_status=$(amixer sget Master | awk -F'[][]' '/%/ { if ($4 == "on") print $2; else print "X" }' | head -n1)

# Mostrar el resultado
echo "   $volume_status"

