#!/bin/bash

# Definir el directorio donde se guardarán las notas
NOTAS_DIR="$HOME/notas"

# Crear el directorio si no existe
if [ ! -d "$NOTAS_DIR" ]; then
  mkdir -p "$NOTAS_DIR"
fi

# Generar un nombre de archivo basado en la fecha y la hora actual
FECHA_HORA=$(date +"%Y-%m-%d_%H-%M-%S")
ARCHIVO_NOTA="$NOTAS_DIR/$FECHA_HORA.txt"

# Crear el archivo y abrirlo con Neovim
nvim "$ARCHIVO_NOTA"

