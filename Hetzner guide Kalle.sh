cp private_openssh ~/.ssh/
cp public_openssh.txt ~/.ssh/
chmod 600 ~/.ssh/private_openssh
chmod 644 ~/.ssh/public_openssh.txt

ssh -i ~/.ssh/private_openssh root@wordpress.multinomial.se

apt update
apt install -y pigz qemu-utils pv

nano /root/kalsko-htznr-backup-20260902-1230.img.gz

#Copy paste this into the kalsko-htznr-backup-20260902-1230.img.gz file, then Ctrl+O, Ctrl+X.

#!/bin/bash
SOURCE_DISK="/dev/sda"
BACKUP_NAME="/mnt/backup/kalsko-htznr-backup-$(date +%Y%m%d-%H%M).img.gz"
echo "=== Starting disk backup ==="
echo "Source: $SOURCE_DISK"
echo "Destination: $BACKUP_NAME"
dd if="$SOURCE_DISK" bs=1M status=progress | pigz -c > "$BACKUP_NAME"
echo "=== Backup complete ==="
ls -lh "$BACKUP_NAME"

chmod +x /root/kalsko-htznr-backup-20260902-1230.img.gz
bash /root/kalsko-htznr-backup-20260902-1230.img.gz

#Wait for the backup to complete.

exit

scp -i ~/.ssh/private_openssh root@wordpress.multinomial.se:/mnt/backup/kalsko-htznr-backup-20260902-1230.img.gz .

#This is supposed to show whether or not the backup is functional. If it returns 0, the backup is functional.

gzip -t kalsko-htznr-backup-20260902-1230.img.gz
Keys$ echo $?
0

gunzip kalsko-htznr-backup-20260902-1230.img.gz
sudo apt install qemu-utils
qemu-img convert -f raw -O vdi kalsko-htznr-backup-20260902-1230.img kalsko-htznr-backup-20260902-1230.vdi