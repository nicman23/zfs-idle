if [ ! -e accept ]; then
  echo please do read me.
  exit 1
fi

# this might lead to data corruption - it has not for me
# change the hd-idle-zfs.sh file variable to target your array

# this script _requires_ zsh

# also it is a good idea to add a l2arc (ie zpool add zpool cache mirror sda sdb)
# and a special (ie zpool add zpool special mirror sdd sdc)

sudo -v

sudo cp hd-idle-zfs.sh /usr/local/bin/hd-idle-zfs.sh
sudo cp /etc/systemd/system/zfs-idle.service zfs-idle.service

cat << EOF >> /etc/modprobe.d/zfs.conf
options zfs zfs_dirty_data_max_percent=30
options zfs zfs_txg_timeout=1000

