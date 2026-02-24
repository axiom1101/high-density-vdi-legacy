# KVM Home Lab Setup Guide

This document describes the configuration of a local R&D environment used to test virtualization parameters before deploying workloads to production.

**Host OS:** Debian / Ubuntu LTS  
**Hypervisor:** KVM + QEMU + Libvirt

---

## 1. Host Preparation

### System Update & Package Installation

Ensure hardware virtualization (VT-x / AMD-V) is enabled in BIOS/UEFI.

```bash
# Switch to root
sudo -i

# Update system
apt update && apt dist-upgrade -y

# Install virtualization stack & utilities
apt install -y \
  cpu-checker qemu qemu-kvm libvirt-daemon-system virtinst \
  libosinfo-bin chrony qemu-utils dnsmasq-base nmon virt-top \
  libvirt-dev libvirt-clients bridge-utils mc build-essential
```

### Service Configuration

Enable the Libvirt daemon and time synchronization service.

```bash
systemctl enable --now libvirtd
systemctl enable --now chrony
systemctl status chrony
```

---

## 2. Network Configuration (NAT Bridge)

The default NAT bridge `virbr0` is required for VM connectivity.

### Network Definition

Create the definition file `configs/network_default.xml` (if it does not exist):

```xml
<network>
  <name>default</name>
  <bridge name="virbr0"/>
  <forward mode="nat"/>
  <ip address="192.168.122.1" netmask="255.255.255.0">
    <dhcp>
      <range start="192.168.122.2" end="192.168.122.254"/>
    </dhcp>
  </ip>
</network>
```

### Apply Configuration

```bash
# Define and start the network
virsh net-define configs/network_default.xml
virsh net-start default
virsh net-autostart default

# Verify
virsh net-list --all
```

---

## 3. Storage Management

A mixed storage approach is used:
- **LVM** for performance‑critical workloads
- **qcow2** files for portability and backups

### Directory Structure

```bash
mkdir -p /mnt/kvm/{disk,iso}
```

### LVM Setup (Example)

Assuming a volume group `vg_sata` already exists (created during OS installation).

```bash
# Check physical and logical volumes
pvscan
lvs

# Create a 20GB logical volume for a VM
lvcreate -n vm1 -L 20G vg_sata

# Adjust read/write permissions (if required)
lvchange -r none /dev/vg_sata/vm1
```

### qcow2 Image Creation

For file‑based storage (easy to backup and clone):

```bash
qemu-img create -f qcow2 -o preallocation=metadata   /mnt/kvm/disk/vmserver01.qcow2 20G
```

---

## 4. ISO Management

Download required installation media and drivers.

```bash
# Windows installation images
wget -P /mnt/kvm/iso/ http://MY-DOMAIN.ru/Win7.iso

# VirtIO drivers (critical for Windows performance)
wget -P /mnt/kvm/iso/   https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/archive-virtio/virtio-win-0.1.215-2/virtio-win.iso

# Linux LiveCD tools
wget -P /mnt/kvm/iso/   https://download.manjaro.org/xfce/21.2.2/manjaro-xfce-21.2.2-minimal-220123-linux510.iso
```

---

## 5. Verification

### KVM Acceleration Check

```bash
kvm-ok
# Expected output:
# "KVM acceleration can be used"
```

### Kernel Modules

```bash
lsmod | grep kvm
```

---
