#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "[apps] installing from Brewfile..."
brew bundle --file="$SCRIPT_DIR/../Brewfile"
echo "[apps] done"
