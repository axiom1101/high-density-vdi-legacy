# Windows Optimization for High-Density RDP

## 1. GPO Tweaks (Hardware Acceleration)
Enable GPU usage for RDP sessions to support 3D applications.

**Run:** `gpedit.msc`
**Path:** `Computer Configuration -> Administrative Templates -> Windows Components -> Remote Desktop Services -> Remote Desktop Session Host -> Remote Session Environment`

**Settings:**
*   **Use hardware graphics adapters for all Remote Desktop Services sessions:** ENABLED
*   **Configure compression for RemoteFX data:** Optimized to use less network bandwidth (or Minimum memory usage)

## 2. Service & Power Management
*   **Power Plan:** High Performance (Never sleep, Turn off hard disk: 0).
*   **Hibernation:** `powercfg -h off`
*   **Updates:** Disable Windows Update Service.
*   **Defender:** Disable Real-time protection & Uninstall feature.

## 3. Network & Session Isolation

**Application-level traffic routing:**
- Selective tunneling of application traffic through SOCKS5 proxies.
- Independent network paths per session to avoid cross-interference.
- Remote DNS resolution to ensure consistency across isolated environments.

**Environment normalization:**
- Alignment of system and network identifiers across sessions.
- Control of OS-level parameters to ensure deterministic behavior of client software.
- Prevention of resource and identity collisions in high-density environments.
