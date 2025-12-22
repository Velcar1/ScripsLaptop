#!/bin/bash

# Cargar el historial desde el archivo ~/.bash_history
COMMAND=$(tac ~/.zsh_history | sed 's/^: [0-9]*:[0-9]*;//' | awk '!seen[$0]++' | dmenu -i -l 10 -p "Selecciona un comando:")

# Si el usuario selecciona un comando, copiarlo al portapapeles
if [ -n "$COMMAND" ]; then
    echo -n "$COMMAND" | xclip -selection clipboard
    notify-send "Comando copiado al portapapeles:" "$COMMAND"
fi
