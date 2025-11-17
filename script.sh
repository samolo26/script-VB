#!/bin/bash

echo "=== Instalando dependencias ==="
sudo apt update && sudo apt upgrade
sudo apt install -y build-essential dkms linux-headers-$(uname -r)

echo
echo "=== Comprobando CD de Guest Additions ==="
if [ ! -e /dev/sr0 ]; then
    echo "⚠ No se encontró /dev/sr0"
    echo "➡ Ve a VirtualBox: Dispositivos -> Insertar imagen de CD de las 'Guest Additions'"
    exit 1
fi

echo
echo "=== Montando el CD ==="
sudo mkdir -p /media/cdrom
sudo mount /dev/sr0 /media/cdrom

echo
echo "=== Ejecutando instalador ==="
cd /media/cdrom
sudo sh VBoxLinuxAdditions.run

echo
echo "=== Instalación completa ==="
echo "Reinicia la máquina: sudo reboot"
