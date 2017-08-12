#Create an empty file (1K * 4M = 4 GiB).
sudo mkdir -v /var/cache/swap
cd /var/cache/swap
sudo dd if=/dev/zero of=swapfile bs=1K count=4M
sudo chmod 600 swapfile
#Convert newly created file into a swap space file.
sudo mkswap swapfile
#Enable file for paging and swapping.

sudo swapon swapfile
#Verify by: swapon -s or top:

#top -bn1 | grep -i swap
#Should display line like: KiB Swap:  4194300 total,  4194300 free

#To disable, use sudo swapoff swapfile command.
#Add it into fstab file to make it persistent on the next system boot.
echo "/var/cache/swap/swapfile none swap sw 0 0" | sudo tee -a /etc/fstab

#Re-test swap file on startup by:
sudo swapoff swapfile
sudo swapon -va
