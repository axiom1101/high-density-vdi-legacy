# Known Issues & Troubleshooting

A log of errors encountered during deployment and their workarounds.

## 1. Libvirt / KVM Errors

### Error: "Cannot check dnsmasq library"
*   **Context:** Occurs when starting the default network on a fresh Debian install.
*   **Fix:** Missing dependency.
    ```bash
    sudo apt install dnsmasq-base
    ```

### Error: "Network 'default' is not active"
*   **Context:** VMs fail to start network interfaces.
*   **Fix:**
    ```bash
    virsh net-define --file default.xml
    virsh net-start default
    virsh net-autostart --network default
    ```
    *Reference:* [StackExchange: Network default is not active](https://www.xmodulo.com/network-default-is-not-active.html)

### Error: "Unable to locate package spice-vdagent"
*   **Context:** Debian repositories missing the agent.
*   **Fix:** Compile from source or add contrib-non-free repos.

## 2. Performance Issues

### High CPU Usage in Browser/Video
*   **Problem:** Decoding video streams inside VM spiked CPU to 100%.
*   **Workaround:** Installed **h264ify** Chrome extension to force H.264 codec (hardware accelerated) instead of VP8/VP9 (software).

### Screen Resolution
*   **Problem:** Spice client stuck at 800x600.
*   **Fix:** Edited XML video model to QXL with increased VRAM (heads='1').

## 3. Hetzner Specifics

### VNC Connection Drops
*   **Issue:** QEMU VNC server on Rescue system disconnects.
*   **Fix:** Ensure `hostfwd=tcp::3389-:3389` is set correctly and firewall allows port 5901.

### Disk Partitioning
*   **Issue:** Windows installer can't see the disk after `dd`.
*   **Fix:** Must run `partprobe` to reload partition table before starting QEMU.