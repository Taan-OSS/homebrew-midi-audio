#!/bin/bash
set -euo pipefail
if [[ "$(uname -s)" != Darwin || "$(uname -m)" != arm64 ]]; then
  echo "Requires an Apple Silicon Mac. If using Rosetta Terminal, reopen it natively." >&2
  exit 1
fi
if ! command -v brew >/dev/null 2>&1; then
  echo "Install Homebrew from https://brew.sh, then run this script again." >&2
  exit 1
fi
terms="https://github.com/Taan-OSS/homebrew-midi-audio/blob/main/collection-terms.html"
printf '%s\n' "Read the installation terms: $terms"   "Render uploads your MIDI, chosen instrument/settings and optional reference audio."   "These inputs are retained and may be used for model training."   "This beta is unsigned/unnotarized; macOS may require Open Anyway."   "Close midi.audio and all DAWs before continuing."
open "$terms"
printf 'After reading the terms, type AGREE to install (anything else cancels): ' >/dev/tty
read -r answer </dev/tty
[[ "$answer" == AGREE ]] || { echo "Cancelled; nothing installed."; exit 1; }
brew tap Taan-OSS/midi-audio
if brew help trust >/dev/null 2>&1; then
  brew trust --cask taan-oss/midi-audio/midi-audio
fi
brew install --cask Taan-OSS/midi-audio/midi-audio
