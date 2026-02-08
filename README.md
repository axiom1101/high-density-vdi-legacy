# high-density-vdi-legacy

This repository is an archive of **practical engineering work** focused on deploying and operating Windows environments for graphical and test applications under strict hardware constraints.

The project reflects a real-world journey: from a home KVM laboratory to operating Windows on **bare-metal servers** without physical KVM console access.

---

## What This Is

- A collection of **raw commands**, configurations, and notes.
- Knowledge accumulated during **experimental and applied operations**.
- A solution built for specific constraints, not an attempt to mimic enterprise cloud platforms.

Preserved here are:
- Working configurations
- Failed experiments
- Workarounds ("crutches")
- Hardware limitations
- Real-world errors and their fixes

---

## What This Is NOT

- Kubernetes
- Terraform / Ansible
- CI/CD Pipelines
- Universal "Best Practices"
- "Ideal" Architecture

This is **not SaaS**, not a Cloud platform, and not a DevOps showcase.

---

## Environments

### 1. Home Laboratory (R&D)
- **Stack:** Linux (Debian / Ubuntu), KVM / QEMU / libvirt, Spice / QXL, LVM-backed storage.
- **Tools:** `virt-install`, `virt-clone`.
- **Purpose:**
  - Testing Windows versions (XP / 7 / 10).
  - Finding optimal VirtIO drivers.
  - Experiments with CPU topology, VRAM, and networking.
  - Preparing master images.

### 2. Dedicated Servers (Hetzner Production)
- **Stack:** Bare Metal Hardware, QEMU + VNC (Rescue System), Windows Server 2016 / Windows 10.
- **Architecture:** Terminal Services (RDP) directly on hardware.
- **Purpose:**
  - Handling real production loads.
  - Testing RDP session density.
  - Running 3D applications without dedicated GPUs (software/iGPU rendering).

---

## Repository Structure

- [`docs/`](docs/) — Documentation, context, experiments, and issue logs:
  - `00_context_and_scope.md` — Project scope and honest constraints.
  - `01_hetzner_bare_metal_deployment.md` — Step-by-step runbook for dedicated servers.
  - `02_kvm_home_lab_setup.md` — Home KVM cluster setup guide.
  - `03_windows_optimization_guide.md` — Windows tuning for high-density RDP.
  - `98_experiments_and_variants.md` — R&D log: variants tested and rejected.
  - `99_known_issues_and_fixes.md` — Log of errors and workarounds.

- [`scripts/`](scripts/) — Raw command sequences:
  - `hetzner_rescue_install.sh` — Deploying Windows to bare metal via RAM-disk & QEMU.
  - `kvm_host_provision.sh` — Preparing a Linux host for virtualization.
  - `vm_create_commands.sh` — Collection of legacy `virt-install` commands.

- [`configs/`](configs/) — Libvirt XML fragments and network configs:
  - `network_bridge.xml` — Bridge network definition.
  - `vm_domain_tuning.xml` — Fine-tuning for CPU pinning, GPU, and memory.

---

## Important Note / Disclaimer

This repository is preserved in its **historical state** (2014-2018).

Some solutions presented here are:
- Outdated
- Potentially insecure by modern standards
- Sub-optimal for general use

They are left intentionally to demonstrate:
- Real-world constraints of the time.
- The engineering thought process.
- The evolution of solutions.

---

## Purpose of Repository

- Portfolio / Technical Archive.
- Base for environment recovery.
- Demonstration of practical experience with low-level infrastructure.

---

## License

For educational use. Use at your own risk.