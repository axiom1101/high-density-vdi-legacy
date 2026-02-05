# Context & Project Scope

## Project Evolution
This repository documents the evolution of high-density autonomous agents / test applications. The infrastructure went through two distinct phases:

1.  **Phase 1: Home Lab (R&D)**
    *   **Hardware:** Local PC.
    *   **Tech Stack:** Linux (Debian/Ubuntu) + KVM + QEMU + Libvirt.
    *   **Goal:** Testing virtualization overhead, driver compatibility (VirtIO), and automation logic.
    *   **Scale:** ~10 VMs running simultaneously.

2.  **Phase 2: Production (Hetzner Bare Metal)**
    *   **Hardware:** Dedicated Servers (Intel Core i7-3770 / i7-2600, 32GB RAM).
    *   **Tech Stack:** Windows Server 2016 / Windows 10 (Bare Metal) + Terminal Services.
    *   **Goal:** Maximum performance per watt. Virtualization overhead was higher than desirable for the target 3D workloads on this hardware generation.
    *   **Solution:** Switched from KVM VMs to isolated RDP sessions with GPU acceleration enabled via GPO.

## Purpose
This is **NOT** a standard cloud/IaC environment. It is a specialized, purpose-built solution for:
*   Running resource-intensive graphical applications in terminal (RDP/VDI-like) environments without discrete GPUs (software rendering / integrated graphics).
*   Isolating application instances to ensure consistent and independent runtime environments across parallel sessions.
*   Managing a large number of short-lived application instances using scripted session rotation and time-sharing of compute resources.

## Disclaimer
*   Scripts contain legacy commands (QEMU 1.2.0, old VirtIO drivers).
*   Security practices (disabling Defender/Updates) are specific to this isolated environment and NOT recommended for general-purpose servers.