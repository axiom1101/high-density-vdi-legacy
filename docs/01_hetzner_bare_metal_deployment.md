# Hetzner Bare Metal Windows Deployment

## Phase 1: Rescue System
1. Login to Hetzner Robot.
2. Select Server → **Rescue** → **Linux 64bit** → Activate.
3. Copy the generated password.
4. Reboot the server.
5. Connect via SSH (`putty` or terminal):
   ```bash
   ssh root@<SERVER_IP>
   ```

## Phase 2: Installation
1. Execute the script `scripts/hetzner_rescue_install.sh`.
2. Wait for the ISO to download into RAM.
3. After QEMU starts, connect via **TightVNC Viewer**:
   - Host: `<SERVER_IP>:1`
   - Password: `1` (or as configured in QEMU command)

## Phase 3: Windows Setup (Critical)
**Before clicking "Install Now":**
1. Press `SHIFT + F10` to open CMD.
2. Prepare the partition table:
   ```cmd
   diskpart
   list disk
   select disk 0
   clean
   convert mbr
   exit
   ```
3. Proceed with installation:
   - Select **Standard Evaluation with GUI**
   - Create a user with Administrator rights

## Phase 4: Post‑Install Configuration
1. Perform a **Hard Reset** via Hetzner Robot panel.
2. Boot into installed Windows via RDP.

### Drivers
- Chipset: **Intel Chipset INF Utility**
- Graphics: **Intel Graphics Driver 15.33**

### Optimization
- Disable hibernation:
  ```cmd
  powercfg -h off
  ```
- Remove Windows Defender:
  ```powershell
  Uninstall-WindowsFeature -Name Windows-Defender
  ```
- Disable Windows Update service.
