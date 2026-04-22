#!/usr/bin/env bash
set -euo pipefail

REPO_URL="https://github.com/am3rb3ar/machine-setup.git"
PLAYBOOK="machine-setup/local.yml"
DRY_RUN=false

usage() {
  echo "Usage: $0 [--dry-run]"
  echo "  --dry-run  Run ansible-pull in check mode (no changes applied)"
  exit 1
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --dry-run) DRY_RUN=true; shift ;;
    *) usage ;;
  esac
done

if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

echo "Installing Ansible..."
brew install ansible

echo "Installing Ansible collections..."
ansible-galaxy collection install community.general

if $DRY_RUN; then
  echo "Running ansible-pull (dry run)..."
  ansible-pull --check --diff -U "$REPO_URL" "$PLAYBOOK"
else
  echo "Running ansible-pull..."
  ansible-pull -U "$REPO_URL" "$PLAYBOOK"
fi
