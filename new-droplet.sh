#!/bin/bash

# Update & upgrade
sudo apt-get update && sudo apt-get upgrade -y
adduser deploy
usermod -aG sudo deploy

# Basic firewall
ufw allow OpenSSH
ufw allow 80
ufw allow 443
ufw enable

# Install Docker & Docker Compose
sudo apt-get install -y ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
sudo usermod -aG docker deploy

# Verify Docker installation
docker --version
docker compose version

# Install SQL Server
