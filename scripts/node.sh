#!/bin/bash
set -euo pipefail

PNPM_VERSION="10.10"

install_node() {
  if brew list node &>/dev/null; then
    echo "[node] already installed, upgrading to latest..."
    brew upgrade node
  else
    echo "[node] installing latest node..."
    brew install node
  fi
}

install_pnpm() {
  local current_version
  if command -v pnpm &>/dev/null; then
    current_version=$(pnpm --version | cut -d. -f1,2)
    if [[ "$current_version" == "$PNPM_VERSION" ]]; then
      echo "[node] pnpm $PNPM_VERSION already installed, skipping"
      return 0
    fi
    echo "[node] updating pnpm to $PNPM_VERSION..."
  else
    echo "[node] installing pnpm $PNPM_VERSION..."
  fi
  npm install -g "pnpm@${PNPM_VERSION}"
}

install_node
install_pnpm

echo "[node] done (node $(node -v), pnpm $(pnpm --version))"
