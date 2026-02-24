# R&D: Experiments & Variants

During the development, multiple configurations were tested to balance performance and compatibility.

## 1. OS Variations
*   **Windows XP:** Tested for lightweight footprint. Required specific `virtio-win` drivers and `MiniXP_Last_AHCI.ISO`. Abandoned due to game compatibility issues.
*   **Windows 7:** Stable, but high resource usage compared to stripped-down Win10.
*   **Linux (Lubuntu/Manjaro):** Tested as a host system and potential guest.
    *   *Tools used:* `installimage` (Hetzner tool) with custom LVM partitioning:
        `installimage -p /boot:ext2:256M,lvm:vg_sata:all -v vg_sata:root:/:ext3:200G...`

## 2. CPU Topology Tuning
Tested different CPU modes to reduce latency:
*   **Variant A (Passthrough):** Best performance, exposes host CPU model.
    ```xml
    <cpu mode='host-passthrough' check='none'>
      <topology sockets='1' cores='4' threads='2'/>
    </cpu>
    ```
*   **Variant B (Host Model):** Better for migration (not used here), slightly higher overhead.
    ```xml
    <cpu mode='host-model' check='partial'/>
    ```

## 3. Graphics & Memory (Spice/QXL)
Tuning video memory for 2D/3D rendering in KVM:
*   **High Performance:** `ram='131072' vram='131072'` (128MB)
*   **Low Resource:** `ram='65536' vram='16384'` (16MB) - Caused artifacts in 3D.

## 4. Failed Experiments
*   **Offline .NET Framework 3.5:** Attempted to install `microsoft-windows-netfx3-ondemand-package.cab` via DISM/SXS on isolated VMs. Encountered dependency issues, switched to pre-baked images.
*   **GPU Passthrough:** Investigated Intel GVT-g and `virtio-gpu` for sharing iGPU, but setup complexity on consumer hardware (i7-3770) outweighed benefits compared to the RDP approach.