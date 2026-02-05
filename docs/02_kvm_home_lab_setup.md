# KVM Home Lab Setup Guide

This document details the configuration of the local R&D environment used for testing virtualization parameters before deploying to production.

**Host OS:** Debian / Ubuntu LTS
**Hypervisor:** KVM + QEMU + Libvirt

## 1. Host Preparation

### System Update & Package Installation
Ensure hardware virtualization (VT-x / AMD-V) is enabled in BIOS.

# Switch to root
sudo -i

# Update repositories
apt update && apt dist-upgrade -y

# Install Virtualization Stack & Utilities
apt install cpu-checker qemu qemu-kvm libvirt-daemon-system virtinst \
libosinfo-bin chrony qemu-utils dnsmasq-base nmon virt-top \
libvirt-dev libvirt-clients bridge-utils mc build-essential

### Service Configuration
Enable the Libvirt daemon and time synchronization service.

systemctl enable --now libvirtd
systemctl enable --now chrony
systemctl status chrony

## 2. Network Configuration (NAT Bridge)

The default bridge `virbr0` is required for VM connectivity.

1.  **Create Definition File:**
    Create `configs/network_default.xml` (if not exists):

    <network>
     <name>default</name>
     <bridge name="virbr0" />
     <forward mode="nat"/>
     <ip address="192.168.122.1" netmask="255.255.255.0">
      <dhcp>
      <range start="192.168.122.2" end="192.168.122.254" />
      </dhcp>
     </ip>
    </network>

2.  **Apply Configuration:**

    # Define and start the network
    virsh net-define configs/network_default.xml
    virsh net-start default
    virsh net-autostart --network default
    
    # Verify
    virsh net-list --all

## 3. Storage Management

Used a mix of **LVM** (Logical Volume Manager) for performance and **qcow2** files for portability.

### Directory Structure
mkdir -p /mnt/kvm/{disk,iso}

### LVM Setup (Example)
Assuming a volume group `vg_sata` exists (created during OS install via `installimage` or manual partitioning).

# Check physical volumes
pvscan
lvs

# Create a 20GB Logical Volume for a VM
lvcreate -n vm1 -L 20G vg_sata

# Set read/write permissions (if needed)
lvchange -r none /dev/vg_sata/vm1

### Qcow2 Image Creation
For file-based storage (easier to backup/clone):

qemu-img create -f qcow2 -o preallocation=metadata /mnt/kvm/disk/vmserver01.qcow2 20G

## 4. ISO Management

Downloading required installation media and drivers.

# Windows 7 / 10 Images
wget -P /mnt/kvm/iso/ http://kometa-vozmezdie.ru/Win7.iso

# VirtIO Drivers (Critical for Windows performance)
wget -P /mnt/kvm/iso/ https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.215-2/virtio-win.iso

# Linux Tools (LiveCD)
wget -P /mnt/kvm/iso/ https://download.manjaro.org/xfce/21.2.2/manjaro-xfce-21.2.2-minimal-220123-linux510.iso

## 5. Verification

Check if KVM is accessible:
kvm-ok
# Output should be: "KVM acceleration can be used"


Check loaded modules:
lsmod | grep kvm
