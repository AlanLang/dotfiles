#!/bin/bash
set -euo pipefail

install_fonts() {
  echo "[fonts] installing FiraCode Nerd Font..."
  brew install --cask font-fira-code-nerd-font
  echo "[fonts] done"
}

install_fonts
