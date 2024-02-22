#!/bin/bash

# Define the username
USERNAME="bckp"

# Install Samba
sudo apt-get update -y
sudo apt-get install -y samba
echo "Username: $USERNAME"

# Add a new user
sudo adduser $USERNAME
sudo smbpasswd -a $USERNAME
echo "Username: $USERNAME"

# Allow Samba through the firewall
sudo ufw allow Samba
#sudo ufw enable
echo "Username: $USERNAME"

# Set permissions on parent directories
sudo chmod +rx /home
sudo chmod +rx /home/$USERNAME
sudo chmod +rx /home/$USERNAME/Desktop

# Create a Shared Directory
sudo mkdir /home/$USERNAME/Desktop/sharez

# Configure Samba
echo "[sharez]
   path = /home/$USERNAME/sharez
   read only = no
   browsable = yes
   guest ok = yes
   write ok = yes
   writable = yes
   valid users = $USERNAME" | sudo tee -a /etc/samba/smb.conf

# Restart Samba service
sudo service smbd restart
