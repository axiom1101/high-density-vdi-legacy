#!/bin/bash
# HETZNER RESCUE MODE INSTALLATION SCRIPT
# Target: Install Windows Server 2016 / Windows 10 directly to /dev/sda
# Method: QEMU over VNC

# 1. Prepare the disk (Wipe start of disk)
dd if=/dev/zero of=/dev/sda bs=1M count=1
partprobe

# 2. Create RAM disk to hold the ISO (since we can't mount the physical disk yet)
# Allocating 8GB of RAM for tmpfs
mount -t tmpfs -o size=8000m tmpfs /mnt

# 3. Download Images (Historical Links - Verify availability)
# Windows Server 2016
wget -P /mnt http://kometa-vozmezdie.ru/en_windows_server_2016_vl_x64_by_AG_08.2021.iso
# OR Windows 10
# wget -P /mnt http://kometa-vozmezdie.ru/win10.iso

# 4. Download Legacy QEMU (Required for specific compatibility)
wget /tmp https://netix.dl.sourceforge.net/project/kvm/qemu-kvm/1.2.0/qemu-kvm-1.2.0.tar.gz | tar xvf /tmp/qemu-kvm-1.2.0.tar.gz

# 5. Launch QEMU VNC Session
# Maps the physical drive /dev/sda as the primary HDD for the VM
# Maps the ISO from RAM as CD-ROM
echo "Starting QEMU... Connect via VNC Viewer to IP:5901 (Password: 1)"

qemu-system-x86_64 \
  -net nic -net user,hostfwd=tcp::3389-:3389 \
  -m 2048M \
  -enable-kvm \
  -cpu host,+nx \
  -M pc \
  -smp 2 \
  -vga std \
  -usbdevice tablet \
  -k en-us \
  -cdrom /mnt/en_windows_server_2016_vl_x64_by_AG_08.2021.iso \
  -hda /dev/sda \
  -boot once=d \
  -vnc :1

# Note: After installation inside VNC, do NOT reboot immediately.
# Perform 'diskpart' steps inside Windows Setup (Shift+F10).
