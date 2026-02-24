#!/bin/bash
# KVM HOST SETUP (Debian/Ubuntu)

# 1. Install Packages
apt update && apt dist-upgrade -y
apt install cpu-checker qemu qemu-kvm libvirt-daemon-system virtinst libosinfo-bin chrony qemu-utils dnsmasq-base nmon virt-top libvirt-dev libvirt-clients bridge-utils mc build-essential

# 2. Enable Services
systemctl enable --now libvirtd
systemctl enable --now chrony

# 3. Network Bridge Setup (Requires XML definition)
# virsh net-define --file configs/network_bridge.xml
# virsh net-start default
# virsh net-autostart --network default

# 4. Storage Setup (LVM)
# pvscan
# lvcreate -n vm1 -L 20G vg_sata
# lvchange -r none /dev/vg_sata/vm1

# 5. Create Directories
mkdir -p /mnt/kvm/{disk,iso}

# 6. Timezone
timedatectl set-timezone Europe/Kaliningrad