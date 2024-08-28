#!/bin/bash

# Iniciar el agente SSH y exportar la variable de entorno necesaria
eval $(ssh-agent -s)

# Agregar la clave privada especificada al agente SSH
ssh-add ~/.ssh/id_rsa_ed25519
