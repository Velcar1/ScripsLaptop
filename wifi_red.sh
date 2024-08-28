#!/bin/bash

# Obtener lista de SSID disponibles
networks=$(nmcli -t -f SSID dev wifi | grep -v '^$' | sort -u)

# Usar dmenu para seleccionar un SSID
chosen_network=$(echo "$networks" | dmenu -p "Selecciona la red Wi-Fi:")

# Si no se selecciona nada, salir
if [ -z "$chosen_network" ]; then
    echo "No se seleccionó ninguna red. Saliendo..."
    exit 1
fi

# Intentar conectarse a la red seleccionada
nmcli dev wifi connect "$chosen_network" || {
    # Si falla, solicitar la contraseña
    wifi_password=$(echo "" | dmenu -p "Introduce la contraseña para $chosen_network:")

    # Intentar conectarse con la contraseña proporcionada
    nmcli dev wifi connect "$chosen_network" password "$wifi_password"
}

