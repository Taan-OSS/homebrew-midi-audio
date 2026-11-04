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
terms="https://raw.githubusercontent.com/Taan-OSS/homebrew-midi-audio/main/collection-terms.html"
terms_dir=$(mktemp -d "${TMPDIR:-/tmp}/midi-audio-terms.XXXXXX")
trap 'rm -rf "$terms_dir"' EXIT
curl --fail --silent --show-error --location "$terms" -o "$terms_dir/terms.html"
printf '%s\n' \
  "Opening the readable installation terms in your browser." \
  "Render uploads your MIDI, chosen instrument/settings and optional reference audio." \
  "These inputs are retained and may be used for model training." \
  "This beta is unsigned/unnotarized; macOS may require Open Anyway." \
  "Close midi.audio and all DAWs before continuing."
open -a Safari "$terms_dir/terms.html"
printf '\nReturn to THIS TERMINAL after reading the terms.\nType AGREE and press Enter to start installation (anything else cancels): ' >/dev/tty
read -r answer </dev/tty
[[ "$answer" == AGREE ]] || { echo "Cancelled; nothing installed."; exit 1; }
brew tap Taan-OSS/midi-audio
if brew help trust >/dev/null 2>&1; then
  brew trust --cask taan-oss/midi-audio/midi-audio
fi
brew install --cask Taan-OSS/midi-audio/midi-audio
