#!/bin/bash

# Obtener lista de dispositivos Wi-Fi (excluyendo wifi-p2p)
devices=$(nmcli device | grep wifi | grep -v "wifi-p2p" | awk '{print $1, "(" $2 ")"}')

# Usar dmenu para seleccionar un dispositivo
chosen_device=$(echo "$devices" | dmenu -p "Selecciona el dispositivo Wi-Fi:" | awk '{print $1}')

# Si no se selecciona nada, salir
if [ -z "$chosen_device" ]; then
    echo "No se seleccionó ningún dispositivo. Saliendo..."
    exit 1
fi

# Desconectar todos los dispositivos excepto el seleccionado
for device in $(echo "$devices" | awk '{print $1}'); do
    if [ "$device" != "$chosen_device" ]; then
        nmcli device disconnect "$device"
    else
        nmcli device connect "$device"
    fi
done

