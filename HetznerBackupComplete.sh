kalle@KalleSTATION:/mnt/c/Windows/System32$ cd /mnt/c/Users/kalle/JENSEN-uppgifter/NationAPL/"Hetzer Keys"

kalle@KalleSTATION:/mnt/c/Users/kalle/JENSEN-uppgifter/NationAPL/Hetzer Keys$ cp private_openssh ~/.ssh/
kalle@KalleSTATION:/mnt/c/Users/kalle/JENSEN-uppgifter/NationAPL/Hetzer Keys$ cp public_openssh.txt ~/.ssh/
kalle@KalleSTATION:/mnt/c/Users/kalle/JENSEN-uppgifter/NationAPL/Hetzer Keys$ chmod 600 ~/.ssh/private_openssh
kalle@KalleSTATION:/mnt/c/Users/kalle/JENSEN-uppgifter/NationAPL/Hetzer Keys$ chmod 644 ~/.ssh/public_openssh.txt

kalle@KalleSTATION:/mnt/c/Users/kalle/JENSEN-uppgifter/NationAPL/Hetzer Keys$ ssh -i ~/.ssh/private_openssh root@wordpress.multinomial.se



Welcome to Ubuntu 24.04.4 LTS (GNU/Linux 6.8.0-138-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/pro

 System information as of Tue Sep  1 01:08:26 PM UTC 2026

  System load:  0.25               Processes:             159
  Usage of /:   91.6% of 37.23GB   Users logged in:       1
  Memory usage: 22%                IPv4 address for eth0: 46.62.248.133
  Swap usage:   0%                 IPv6 address for eth0: 2a01:4f9:c013:9003::1

  => / is using 91.6% of 37.23GB

 * Canonical Workshop gives developers fast, composable, reproducible, and
   secure developer environments that are perfect for agentic workflows.

   https://ubuntu.com/workshop

Welcome to the Hetzner Cloud App.

Checkout the documentation at https://docs.hetzner.com

Generated passwords can be found at /root/.hcloud_password

To delete this message of the day: rm -rf /etc/update-motd.d/90-hcloud-app

Expanded Security Maintenance for Applications is not enabled.

64 updates can be applied immediately.
24 of these updates are standard security updates.
To see these additional updates run: apt list --upgradable

Enable ESM Apps to receive additional future security updates.
See https://ubuntu.com/esm or run: sudo pro status


You have mail.
Last login: Tue Sep  1 12:38:06 2026 from 94.191.152.187



root@komvux-ubuntu-4gb-hel1-2:~# lsblk
NAME    MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
sda       8:0    0 38.1G  0 disk
├─sda1    8:1    0 37.9G  0 part /tmp/fsa/20260901-112806-000a3929-00
│                                /
├─sda14   8:14   0    1M  0 part
└─sda15   8:15   0  256M  0 part /boot/efi
sdb       8:16   0  100G  0 disk /mnt/backup
sr0      11:0    1 1024M  1 rom
root@komvux-ubuntu-4gb-hel1-2:~# df -h
Filesystem      Size  Used Avail Use% Mounted on
tmpfs           382M  952K  382M   1% /run
/dev/sda1        38G   35G  1.6G  96% /
tmpfs           1.9G     0  1.9G   0% /dev/shm
tmpfs           5.0M     0  5.0M   0% /run/lock
tmpfs           1.9G     0  1.9G   0% /run/qemu
/dev/sda15      253M  6.2M  246M   3% /boot/efi
tmpfs           382M   12K  382M   1% /run/user/0
/dev/sdb         98G   16G   77G  18% /mnt/backup

root@komvux-ubuntu-4gb-hel1-2:~# apt update
Hit:1 https://download.opensuse.org/repositories/Archiving:/Backup:/Rear/xUbuntu_24.04  InRelease
Hit:2 https://mirror.hetzner.com/ubuntu/packages noble InRelease
Hit:3 https://mirror.hetzner.com/ubuntu/packages noble-updates InRelease
Hit:4 https://mirror.hetzner.com/ubuntu/packages noble-backports InRelease
Hit:5 https://mirror.hetzner.com/ubuntu/security noble-security InRelease
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
47 packages can be upgraded. Run 'apt list --upgradable' to see them.

root@komvux-ubuntu-4gb-hel1-2:~# apt install -y pigz qemu-utils pv
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
pigz is already the newest version (2.8-1).
qemu-utils is already the newest version (1:8.2.2+ds-0ubuntu1.18).
pv is already the newest version (1.8.5-2build1).
The following package was automatically installed and is no longer required:
  extlinux
Use 'apt autoremove' to remove it.
0 upgraded, 0 newly installed, 0 to remove and 47 not upgraded.

root@komvux-ubuntu-4gb-hel1-2:~# nano /root/htznr_backup.sh
#!/bin/bash
SOURCE_DISK="/dev/sda"
BACKUP_NAME="/root/htznr-backup-$(date +%Y%m%d-%H%M).img.gz"
echo "=== Starting disk backup ==="
echo "Source: $SOURCE_DISK"
echo "Destination: $BACKUP_NAME"
dd if="$SOURCE_DISK" bs=1M status=progress | pigz -c > "$BACKUP_NAME"
echo "=== Backup complete ==="
ls -lh "$BACKUP_NAME"

root@komvux-ubuntu-4gb-hel1-2:~# chmod +x /root/htznr_backup.sh
root@komvux-ubuntu-4gb-hel1-2:~# bash /root/htznr_backup.sh
=== Starting disk backup ===
Source: /dev/sda
Destination: /root/htznr-backup-20260902-0728.img.gz

#Detta märkte jag inte tills senare men lägg märke till felmedellandet, serverns root folder hade fått slut på utrymme.

27525120000 bytes (28 GB, 26 GiB) copied, 513 s, 53.7 MB/spigz: abort: write error on <stdout> (No space left on device)
=== Backup complete ===
-rw-r--r-- 1 root root 16G Sep  2 07:37 /root/htznr-backup-20260902-0728.img.gz

root@komvux-ubuntu-4gb-hel1-2:~# exit
logout
Connection to wordpress.multinomial.se closed.

kalle@KalleSTATION:/mnt/c/Users/kalle/JENSEN-uppgifter/NationAPL/Hetzer Keys$ scp -i ~/.ssh/private_openssh root@wordpress.multinomial.se:/root/htznr-backup-20260902-0728.img.gz .
htznr-backup-20260902-0728.img.gz                                                     100%   15GB  21.9MB/s   12:05

kalle@KalleSTATION:/mnt/c/Users/kalle/JENSEN-uppgifter/NationAPL/Hetzer Keys$ ls -lh
total 16G
-rwxrwxrwx 1 kalle kalle  16G Sep  2 09:52 htznr-backup-20260902-0728.img.gz
-rwxrwxrwx 1 kalle kalle 1.5K Nov 11  2025 private.ppk
-rwxrwxrwx 1 kalle kalle 1.7K Nov 11  2025 private_openssh
-rwxrwxrwx 1 kalle kalle  477 Nov 11  2025 public
-rwxrwxrwx 1 kalle kalle  397 Nov 11  2025 public_openssh.txt

kalle@KalleSTATION:/mnt/c/Users/kalle/JENSEN-uppgifter/NationAPL/Hetzer Keys$ gunzip htznr-backup-20260902-0728.img.gz

gzip: htznr-backup-20260902-0728.img.gz: unexpected end of file

kalle@KalleSTATION:/mnt/c/Users/kalle/JENSEN-uppgifter/NationAPL/Hetzer Keys$ gzip -t htznr-backup-20260902-0728.img.gz

gzip: htznr-backup-20260902-0728.img.gz: unexpected end of file

kalle@KalleSTATION:/mnt/c/Users/kalle/JENSEN-uppgifter/NationAPL/Hetzer Keys$ ssh -i ~/.ssh/private_openssh root@wordpress.multinomial.se

root@komvux-ubuntu-4gb-hel1-2:~# ls -lh /root/htznr-backup-20260902-0728.img.gz
-rw-r--r-- 1 root root 16G Sep  2 07:37 /root/htznr-backup-20260902-0728.img.gz
root@komvux-ubuntu-4gb-hel1-2:~# stat -c '%s' /root/htznr-backup-20260902-0728.img.gz
16640995328
root@komvux-ubuntu-4gb-hel1-2:~# stat -c '%s' htznr-backup-20260902-0728.img.gz
16640995328

root@komvux-ubuntu-4gb-hel1-2:~# rm /root/htznr-backup-20260902-0728.img.gz

root@komvux-ubuntu-4gb-hel1-2:~# lsblk
NAME    MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
sda       8:0    0 38.1G  0 disk
├─sda1    8:1    0 37.9G  0 part /tmp/fsa/20260901-112806-000a3929-00
│                                /
├─sda14   8:14   0    1M  0 part
└─sda15   8:15   0  256M  0 part /boot/efi
sdb       8:16   0  100G  0 disk /mnt/backup
sr0      11:0    1 1024M  1 rom

root@komvux-ubuntu-4gb-hel1-2:~# df -h
Filesystem      Size  Used Avail Use% Mounted on
tmpfs           382M  948K  382M   1% /run
/dev/sda1        38G  5.0G   31G  14% /
tmpfs           1.9G     0  1.9G   0% /dev/shm
tmpfs           5.0M     0  5.0M   0% /run/lock
tmpfs           1.9G  220K  1.9G   1% /run/qemu
/dev/sda15      253M  6.2M  246M   3% /boot/efi
/dev/sdb         98G   77G   17G  83% /mnt/backup
tmpfs           382M   12K  382M   1% /run/user/0

root@komvux-ubuntu-4gb-hel1-2:~# ls -lah /mnt/backup
total 77G
drwxr-xr-x 2 root root 4.0K Sep  1 22:45 .
drwxr-xr-x 4 root root 4.0K Sep  1 07:11 ..
-rw-r--r-- 1 root root  17G Sep  1 22:32 ahmed-hetzner-backup-20260901-2227.img.gz
-rw-r--r-- 1 root root  120 Sep  1 22:35 ahmed-hetzner-backup-20260901-2227.img.gz.sha256
-rw-r--r-- 1 root root  17G Sep  1 16:40 ak-hetzner-backup-20260901-1631.img.gz
-rw-r--r-- 1 root root  16G Sep  1 14:51 anna-hetzner-backup-20260901-1444.img.gz
-rw-r--r-- 1 root root  13G Sep  1 13:57 hetzner-wordpress.fsa
-rw-r--r-- 1 root root  16G Sep  1 11:40 server.img.gz

root@komvux-ubuntu-4gb-hel1-2:~# nano /root/htznr_backup.sh
#!/bin/bash
SOURCE_DISK="/dev/sda"
BACKUP_NAME="/mnt/backup/kalsko-htznr-backup-$(date +%Y%m%d-%H%M).img.gz"
echo "=== Starting disk backup ==="
echo "Source: $SOURCE_DISK"
echo "Destination: $BACKUP_NAME"
dd if="$SOURCE_DISK" bs=1M status=progress | pigz -c > "$BACKUP_NAME"
echo "=== Backup complete ==="
ls -lh "$BACKUP_NAME"

root@komvux-ubuntu-4gb-hel1-2:~# bash /root/htznr_backup.sh
=== Starting disk backup ===
Source: /dev/sda
Destination: /mnt/backup/kalsko-htznr-backup-20260902-1230.img.gz
40944795648 bytes (41 GB, 38 GiB) copied, 825 s, 49.6 MB/s
39064+0 records in
39064+0 records out
40961572864 bytes (41 GB, 38 GiB) copied, 825.525 s, 49.6 MB/s
=== Backup complete ===
-rw-r--r-- 1 root root 35G Sep  2 12:44 /mnt/backup/kalsko-htznr-backup-20260902-1230.img.gz

root@komvux-ubuntu-4gb-hel1-2:~# exit

kalle@KalleSTATION:/mnt/c/Users/kalle/JENSEN-uppgifter/NationAPL/Hetzer Keys$ scp -i ~/.ssh/private_openssh root@wordpress.multinomial.se:/mnt/backup/kalsko-htznr-backup-20260902-1230.img.gz .
kalsko-htznr-backup-20260902-1230.img.gz                                              100%   35GB  26.3MB/s   22:33
kalle@KalleSTATION:/mnt/c/Users/kalle/JENSEN-uppgifter/NationAPL/Hetzer Keys$ gzip -t kalsko-htznr-backup-20260902-1230.img.gz
kalle@KalleSTATION:/mnt/c/Users/kalle/JENSEN-uppgifter/NationAPL/Hetzer Keys$ echo $?
0

kalle@KalleSTATION:/mnt/c/Users/kalle/JENSEN-uppgifter/NationAPL/Hetzer Keys$ gunzip kalsko-htznr-backup-20260902-1230.img.gz
kalle@KalleSTATION:/mnt/c/Users/kalle/JENSEN-uppgifter/NationAPL/Hetzer Keys$ sudo apt install qemu-utils

kalle@KalleSTATION:/mnt/c/Users/kalle/JENSEN-uppgifter/NationAPL/Hetzer Keys$ qemu-img convert -f raw -O vdi kalsko-htznr-backup-20260902-1230.img kalsko-htznr-backup-20260902-1230.vdi