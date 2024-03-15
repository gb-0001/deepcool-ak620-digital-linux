#!/bin/bash

sudo cp -rf deepcool-ak620-digital.service /lib/systemd/system/
sudo cp -rf deepcool-ak620-digital-restart.service /lib/systemd/system/
sudo cp -rf deepcool-ak620-digital.py /usr/bin/deepcool-ak620-digital.py



# Créer un environnement virtuel Python
/usr/bin/python3 -m venv ~/venv

# Activer l'environnement virtuel
source ~/venv/bin/activate

# Installer les paquets Python nécessaires
pip install hid psutil

# Modifier les fichiers de service
sed -i 's|ExecStart=.*|ExecStart= /root/venv/bin/python /usr/bin/deepcool-ak620-digital.py|' /lib/systemd/system/deepcool-ak620-digital.service
sed -i 's|ExecStart=.*|ExecStart= /root/venv/bin/python /usr/bin/deepcool-ak620-digital.py|' /lib/systemd/system/deepcool-ak620-digital-restart.service

sudo chmod +x /usr/bin/deepcool-ak620-digital.py

sudo systemctl enable deepcool-ak620-digital.service
sudo systemctl enable deepcool-ak620-digital-restart.service

# Redémarrer le service
sudo systemctl daemon-reload
sudo systemctl restart deepcool-ak620-digital.service
