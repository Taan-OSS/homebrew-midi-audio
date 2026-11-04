# midi.audio for macOS

Homebrew distribution of the midi.audio standalone app, VST3 and Audio Unit.
Apple Silicon (M-series), macOS 13+ and internet access are required. Rendering
runs on our hosted service; no GPU driver, Python, Docker or model download is needed.

## Install

Install [Homebrew](https://brew.sh) first if needed. Close midi.audio and your DAWs.
Read [the installation and collection terms](collection-terms.html) before installing.
The terminal installer cannot show the graphical PKG agreement screen; our helper
opens a readable copy of the terms in Safari. Return to Terminal, type `AGREE`
and press Enter to start installation:

```sh
curl -fL https://raw.githubusercontent.com/Taan-OSS/homebrew-midi-audio/main/scripts/install.sh -o /tmp/midi-audio-install.sh
less /tmp/midi-audio-install.sh
bash /tmp/midi-audio-install.sh
```

Alternatively, after reviewing and accepting the terms:

```sh
brew tap Taan-OSS/midi-audio
# Newer Homebrew versions require explicit trust of this one cask:
brew trust --cask taan-oss/midi-audio/midi-audio
brew install --cask Taan-OSS/midi-audio/midi-audio
```

Review this repository before trusting the cask. If an older Homebrew reports
that `trust` is an unknown command, skip that line; the helper detects it automatically. An administrator password is needed for system installation.

**Homebrew is not a Gatekeeper bypass.** Version 0.2.2 is ad-hoc signed but has
no Developer ID signature or Apple notarization. If macOS blocks it, try opening
it, then choose System Settings → Privacy & Security → Open Anyway. Managed Macs
may prohibit that exception. Signing/notarization remains the supported route to
normal distribution without this block. We do not disable Gatekeeper or strip
quarantine in the cask. If Homebrew refuses the unsigned package, download the
[versioned PKG](https://github.com/Taan-OSS/homebrew-midi-audio/releases/tag/v0.2.2)
and use Apple's manual approval workflow.

## Usage

Installed locations:

| Component | Location |
| --- | --- |
| Standalone | `/Applications/midi.audio.app` |
| VST3 | `/Library/Audio/Plug-Ins/VST3/midi.audio.vst3` |
| Audio Unit | `/Library/Audio/Plug-Ins/Components/midi.audio.component` |

### Standalone

1. Open midi.audio from Applications.
2. Import a MIDI file and choose its musical track and instrument.
3. Optionally supply reference audio. Adjust Dynamics/Brightness if desired.
4. Click Render. Internet is required; the first render may wait for the GPU to start.
5. Drag the completed waveform into a DAW audio track, or export WAV (defaults to Downloads).

There is no built-in audio player. Listen to exported audio in your DAW or an audio
player. Low cut, High cut, Compression and Reverb update the exported waveform
locally. MIDI-rest cleanup is always enabled.

### REAPER

1. Restart REAPER after installation; rescan VSTs if midi.audio is not listed.
2. Insert the midi.audio **VST3** on a MIDI track and select that track.
3. Set a time selection, or leave it unset for the full MIDI-item span.
4. Select an instrument and click Render. The REAPER bridge reads MIDI items;
   it does not record keyboard presses or require playback.
5. Drag the rendered waveform to a new audio track at the selected range's start.
   Avoid playing a separate synth on the original MIDI track if you only want the render.

Import MIDI remains available in every host. Other DAWs use native MIDI export
followed by Import MIDI; this release does not automatically read their selected
piano rolls. Logic uses AU; Ableton and other compatible hosts can use VST3.
A detailed guide is installed at `/Library/Application Support/midi.audio/DAW_HANDOFF.md`.

## Data collection

Pressing Render uploads the submitted MIDI (including all tracks in an imported
file), instrument/settings and any custom reference audio. Inputs are retained
for model training under the terms. Merely opening the plugin or selecting a file
does not upload it. Temporary jobs expire after about 24 hours; training contributions
remain until deletion is requested. Uninstalling does not delete server contributions.
See [the full terms](collection-terms.html) and the installed guide for removal.

## Update and uninstall

Close the app and DAWs first:

```sh
brew update
brew upgrade --cask Taan-OSS/midi-audio/midi-audio
# Remove installed app/plugins; local user data is not deliberately purged:
brew uninstall --cask Taan-OSS/midi-audio/midi-audio
```

The cask pins a versioned release and SHA-256; it never downloads a mutable
`current.pkg`. Existing manual installs may need removal/reconciliation before
Homebrew can manage them; do not delete your DAW projects or exported audio.

## Release maintenance

Publish a new versioned installer asset, verify its checksum, then update `version`,
`sha256` and filename in the cask. Never replace an existing version's asset in place.
For a signed release, update the filename and remove the unsigned-beta caveat only
after notarization and fresh-Mac verification. App/model redistribution rights
remain governed by the product terms; a public tap does not publish model weights.
