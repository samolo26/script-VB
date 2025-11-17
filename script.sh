#!/bin/bash

set -e  # Si algo falla, se para el script

echo "=== Actualizando repositorios e instalando paquetes necesarios... ==="
sudo apt update
sudo apt install -y build-essential dkms linux-headers-$(uname -r)

echo
echo "=== Intentando montar el CD de Guest Additions... ==="

# Creamos el punto de montaje si no existe
if [ ! -d /media/cdrom ]; then
    sudo mkdir -p /media/cdrom
fi

# Intentamos montar el CD
if sudo mount /dev/cdrom /media/cdrom 2>/dev/null; then
    echo "CD montado correctamente en /media/cdrom"
else
    echo "No se ha podido montar /dev/cdrom."
    echo "➡ Ve en la barra de VirtualBox a: Dispositivos -> Insertar imagen de CD de las 'Guest Additions'"
    echo "Luego vuelve a ejecutar este script."
    exit 1
fi

echo
echo "=== Ejecutando instalador de Guest Additions... ==="
cd /media/cdrom

# Algunos sistemas usan sh, otros ./ directamente
if sudo sh VBoxLinuxAdditions.run 2>/dev/null; then
    echo "Instalación completada (método sh)."
elif sudo ./VBoxLinuxAdditions.run 2>/dev/null; then
    echo "Instalación completada (método ./)."
else
    echo "⚠ No se ha podido ejecutar VBoxLinuxAdditions.run"
    echo "Revisa el contenido de /media/cdrom con: ls /media/cdrom"
    exit 1
fi

echo
echo "=== TODO LISTO ==="
echo "Reinicia la máquina con: sudo reboot"
