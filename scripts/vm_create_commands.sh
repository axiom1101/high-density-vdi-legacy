#!/bin/bash
# KVM VIRT-INSTALL COLLECTION
# Legacy commands for creating VMs with specific optimizations

# 1. Windows 7 (Standard)
virt-install \
--name vmserver01 \
--noautoconsole \
--accelerate \
--ram=2048 \
--vcpus=2 --cpu host --check-cpu \
--os-type=windows --os-variant win7 \
--disk pool=disk,size=30,bus=virtio,format=qcow2 \
--cdrom /mnt/kvm/iso/Win7.iso \
--network default,model=virtio \
--graphics vnc,listen=0.0.0.0,password=xxxxxxx \
--boot cdrom,hd

# 2. Windows XP (Legacy with VirtIO drivers)
virt-install \
--name WindowsXP \
--autostart \
--noautoconsole \
--accelerate \
--vcpus=1 --cpu host --check-cpu \
--ram 2048 --arch=x86_64 \
--network default,model=virtio \
--cdrom /mnt/kvm/iso/MiniXP_Last_AHCI.ISO \
--disk device=cdrom,path=/mnt/kvm/iso/virtio-win.iso \
--disk path=/mnt/kvm/disk/vmserver03.qcow2,bus=sata \
--graphics vnc,listen=0.0.0.0 \
--os-type generic --boot cdrom,hd

# 3. Linux (Lubuntu/Manjaro)
virt-install \
--name vmserver02 \
--noautoconsole \
--accelerate \
--vcpus=1 --cpu host --check-cpu \
--ram 1024 --arch=x86_64 \
--network default \
--cdrom /mnt/kvm/iso/lubuntu.iso \
--disk path=/mnt/kvm/disk/vmserver02.qcow2 \
--graphics vnc,listen=0.0.0.0,password=xxxxxxx \
--os-type linux --os-variant=ubuntu20.10 --boot cdrom,hd

# 4. Cloning Command
# virt-clone --original <VM_NAME> --auto-clone
