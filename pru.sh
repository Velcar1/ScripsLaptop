#!/bin/bash

# Función para obtener las redes Wi-Fi disponibles y formatearlas para dmenu
obtener_redes() {
    redes=$(nmcli device wifi list | awk '{print $1 "\t" $2}')
    echo -e "$redes" | dmenu -i -p "Selecciona una red:"
}

# Función para conectarse a una red Wi-Fi
conectar_red() {
    nmcli device wifi connect "$1" password "$2"
}

# Obtener la red seleccionada por el usuario
red_seleccionada=$(obtener_redes)

# Si se seleccionó una red, pedir la contraseña y conectar
if [[ -n "$red_seleccionada" ]]; then
    password=$(zenity --password --title "Ingrese la contraseña de la red")
    conectar_red "$(echo "$red_seleccionada" | cut -f1)" "$password"
fi
