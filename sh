sudo chmod -R +x /home/bckp

#!/bin/bash

# Install Samba
sudo apt-get update -y
sudo apt-get install -y samba
sudo adduser USER
sudo smbpasswd -a USER
sudo ufw allow Samba
sudo chmod +rx /home
sudo chmod +rx /home/USER

# Create a Shared Directory
#sudo mkdir /home/ubuntu/Desktop/isoshared

# Configure Samba
echo "[testshare]
   path = /home/USER/testshare
   read only = no
   browsable = yes
   guest ok = yes
   write ok = yes
   writable = yes
   valid users = roman" | sudo tee -a /etc/samba/smb.conf

