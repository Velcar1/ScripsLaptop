#!/bin/bash

# Definir el directorio donde se guardarán las notas
NOTAS_DIR="$HOME/notas"

# Crear el directorio si no existe
if [ ! -d "$NOTAS_DIR" ]; then
  mkdir -p "$NOTAS_DIR"
fi

# Preguntar si se quiere crear una nueva nota o abrir una existente usando dmenu
OPCION=$(echo -e "Crear nueva nota\nAbrir notas existentes" | dmenu -i -p "Elige una opción:")

if [ "$OPCION" == "Crear nueva nota" ]; then
    # Solicitar el nombre de la nueva nota usando dmenu
    NOMBRE_NOTA=$(echo "" | dmenu -i -p "Introduce el nombre de la nueva nota:")

    # Verificar que se ingresó un nombre válido (no vacío)
    if [ -n "$NOMBRE_NOTA" ]; then
        # Ruta completa del archivo de la nueva nota
        ARCHIVO_NOTA="$NOTAS_DIR/$NOMBRE_NOTA.txt"
        
        # Crear el archivo y abrirlo con Neovim
        nvim "$ARCHIVO_NOTA"
    else
        # Mensaje de error si no se ingresa un nombre válido
        echo "Error: No se proporcionó un nombre para la nota."
    fi

elif [ "$OPCION" == "Abrir notas existentes" ]; then
    # Listar todas las notas disponibles (archivos .txt) en el directorio de notas
    NOTA_SELECCIONADA=$(ls "$NOTAS_DIR"/*.txt 2> /dev/null | xargs -n 1 basename | dmenu -i -p "Selecciona una nota:")

    # Verificar si se seleccionó alguna nota
    if [ -n "$NOTA_SELECCIONADA" ]; then
        # Abrir la nota seleccionada con Neovim
        nvim "$NOTAS_DIR/$NOTA_SELECCIONADA"
    else
        echo "No se seleccionó ninguna nota."
    fi
else
    # Mensaje de error si la opción no es válida
    echo "Opción no válida"
fi

