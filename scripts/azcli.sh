#!/bin/bash
ls
sudo -i
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
sudo apt install docker.io -y
sudo systemctl enable --now docker
sudo docker --version