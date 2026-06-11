#!/bin/bash
set -euo pipefail

install_homebrew() {
  if command -v brew &>/dev/null; then
    echo "[homebrew] already installed, skipping"
    return 0
  fi

  echo "[homebrew] installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  # Apple Silicon: add brew to PATH for the current session
  if [[ "$(uname -m)" == "arm64" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi

  echo "[homebrew] done"
}

install_homebrew
