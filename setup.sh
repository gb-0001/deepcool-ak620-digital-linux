#!/bin/bash

cp -rf deepcool-ak620-digital.service /lib/systemd/system/
cp -rf deepcool-ak620-digital-restart.service /lib/systemd/system/
cp -rf deepcool-ak620-digital.py /usr/bin/deepcool-ak620-digital.py


apt install -y python3-venv
# Creer un environnement virtuel Python
/usr/bin/python3 -m venv ~/venv
apt install -y python3-pip

# Activer l'environnement virtuel
source ~/venv/bin/activate

# Installer les paquets Python nÃ©cessaires
pip install hidapi

pip install psutil

# Modifier les fichiers de service
sed -i 's|ExecStart=.*|ExecStart= /root/venv/bin/python /usr/bin/deepcool-ak620-digital.py|' /lib/systemd/system/deepcool-ak620-digital.service
sed -i 's|ExecStart=.*|ExecStart= /root/venv/bin/python /usr/bin/deepcool-ak620-digital.py|' /lib/systemd/system/deepcool-ak620-digital-restart.service

chmod +x /usr/bin/deepcool-ak620-digital.py

systemctl enable deepcool-ak620-digital.service
systemctl enable deepcool-ak620-digital-restart.service

# RedÃ©marrer le service
systemctl daemon-reload
systemctl restart deepcool-ak620-digital.service

systemctl status deepcool-ak620-digital.service
