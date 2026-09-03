cp private_openssh ~/.ssh/
cp public_openssh.txt ~/.ssh/
chmod 600 ~/.ssh/private_openssh
chmod 644 ~/.ssh/public_openssh.txt

ssh -i ~/.ssh/private_openssh root@wordpress.multinomial.se

apt update
apt install -y pigz qemu-utils pv

nano /root/YOURFILENAMEHERE.sh

#Copy paste this into the YOURFILENAMEHERE.sh file, then Ctrl+O, Ctrl+X.

#!/bin/bash
SOURCE_DISK="/dev/sda"
BACKUP_NAME="/mnt/backup/YOURBACKUPNAMEHERE-$(date +%Y%m%d-%H%M).img.gz"
echo "=== Starting disk backup ==="
echo "Source: $SOURCE_DISK"
echo "Destination: $BACKUP_NAME"
dd if="$SOURCE_DISK" bs=1M status=progress | pigz -c > "$BACKUP_NAME"
echo "=== Backup complete ==="
ls -lh "$BACKUP_NAME"

chmod +x /root/YOURBACKUPNAMEHERE.img.gz
bash /root/YOURBACKUPNAMEHERE.img.gz

#Wait for the backup to complete.

exit

scp -i ~/.ssh/private_openssh root@wordpress.multinomial.se:/mnt/backup/YOURBACKUPNAMEHERE.img.gz .

#This is supposed to show whether or not the backup is functional. If it returns 0, the backup is functional.

gzip -t YOURBACKUPNAMEHERE.img.gz
Keys$ echo $?
0

gunzip YOURBACKUPNAMEHERE.img.gz
sudo apt install qemu-utils
qemu-img convert -f raw -O vdi YOURBACKUPNAMEHERE.img YOURBACKUPNAMEHERE.vdi