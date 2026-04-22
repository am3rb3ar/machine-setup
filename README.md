# machine-setup

Ansible-based machine provisioning using `ansible-pull`. Dotfiles and shell environment are managed separately via [chezmoi](https://www.chezmoi.io/).

## Bootstrapping a new machine

### macOS

Run the following on a fresh machine. It will install Homebrew, Ansible, and then run the playbook:

```sh
curl -fsSL https://raw.githubusercontent.com/am3rb3ar/machine-setup/main/bootstrap.sh | bash
```

To preview what would change without applying anything:

```sh
curl -fsSL https://raw.githubusercontent.com/am3rb3ar/machine-setup/main/bootstrap.sh | bash -s -- --dry-run
```

### Subsequent runs

Once Ansible is installed, you can run `ansible-pull` directly to re-apply or update:

```sh
ansible-pull -U https://github.com/am3rb3ar/machine-setup.git machine-setup/local.yml
```

## Structure

```
bootstrap.sh          # One-liner bootstrap for fresh machines
local.yml             # ansible-pull entry point
requirements.yml      # Ansible Galaxy collections
group_vars/all.yml    # Shared variables
roles/
  common/             # Cross-platform tasks
  macos/              # Homebrew packages, casks, and taps
  arch/               # (coming soon)
  debian/             # (coming soon)
```

## Adding packages (macOS)

Edit `roles/macos/vars/main.yml`:

- `homebrew_packages` — CLI tools
- `homebrew_casks` — GUI apps
- `homebrew_taps` — third-party taps (added before packages)
