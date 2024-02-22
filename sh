#!/bin/bash

# Prompt for username
echo "Enter the username:"
read USERNAME

# Install Samba
sudo apt-get update -y
sudo apt-get install -y samba

# Check if the user already exists
if id "$USERNAME" >/dev/null   2>&1; then
    echo "User '$USERNAME' already exists."
else
    # Add a new user
    sudo adduser $USERNAME
fi

# Prompt for Samba password
echo "Enter the SMB password for $USERNAME:"
sudo smbpasswd -a $USERNAME

# Allow Samba through the firewall
# Assuming Samba uses port  445, adjust if different
sudo ufw allow  445

# Set permissions on parent directories
sudo chmod +rx /home
sudo chmod +rx /home/$USERNAME
sudo chmod +rx /home/$USERNAME/Desktop

# Create a Shared Directory
sudo mkdir -p /home/$USERNAME/Desktop/sharez

# Configure Samba
echo "[sharez]
   path = /home/$USERNAME/Desktop/sharez
   read only = no
   browsable = yes
   guest ok = yes
   write ok = yes
   writable = yes
   valid users = $USERNAME" | sudo tee -a /etc/samba/smb.conf

# Restart Samba service
sudo service smbd restart
