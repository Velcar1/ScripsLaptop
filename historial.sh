#!/bin/bash

# Cargar el historial desde el archivo ~/.bash_history
COMMAND=$(tac ~/.bash_history | dmenu -i -p "Selecciona un comando:")

# Si el usuario selecciona un comando, copiarlo al portapapeles
if [ -n "$COMMAND" ]; then
    echo -n "$COMMAND" | xclip -selection clipboard
    notify-send "Comando copiado al portapapeles:" "$COMMAND"
fi
