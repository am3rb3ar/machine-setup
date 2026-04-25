# machine-setup

Ansible-based dotfiles and machine provisioning repo. Runs via `ansible-pull` against localhost.

## Structure

- `local.yml` — main playbook; applies `common`, then an OS-specific role
- `bootstrap.sh` — one-liner bootstrap: installs Homebrew → pipx → Ansible → runs `ansible-pull`
- `roles/common/` — cross-platform tasks (runs on all systems)
- `roles/macos/` — macOS-only tasks and vars (Homebrew packages/casks, system defaults)
- `roles/arch/` — Arch Linux tasks
- `roles/debian/` — Debian/Ubuntu tasks
- `requirements.yml` — Ansible Galaxy collections (`community.general`)

## Running

```bash
# Bootstrap a fresh machine
curl -sSL https://raw.githubusercontent.com/am3rb3ar/machine-setup/main/bootstrap.sh | bash

# Re-run locally after edits
ansible-pull -vvv -U <repo-url> local.yml

# Dry run
ansible-pull -vvv --check --diff -U <repo-url> local.yml
```

## Adding tools

- **macOS Homebrew package/cask** → `roles/macos/vars/main.yml` under `homebrew_packages` or `homebrew_casks`
- **Cross-platform tool** → `roles/common/tasks/main.yml` using `ansible.builtin.stat` + `ansible.builtin.shell` for idempotency (check if already installed before running the installer)
- **OS-specific task** → the appropriate role's `tasks/main.yml`
