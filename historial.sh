#!/bin/bash

# Cargar el historial desde el archivo ~/.bash_history
COMMAND=$(sed 's/^: [0-9]*:[0-9]*;//' ~/.zsh_history | dmenu -i -l 10 -p "Selecciona un comando:")

# Si el usuario selecciona un comando, copiarlo al portapapeles
if [ -n "$COMMAND" ]; then
    echo -n "$COMMAND" | xclip -selection clipboard
    notify-send "Comando copiado al portapapeles:" "$COMMAND"
fi
