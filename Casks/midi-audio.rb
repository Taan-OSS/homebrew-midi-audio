cask "midi-audio" do
  version "0.2.2"
  sha256 "2665f85c36e530496a6d56385f888b6faa5a1582cdd6ea64c7d0dfd5d8db85e1"

  url "https://github.com/Taan-OSS/homebrew-midi-audio/releases/download/v#{version}/midi-audio-#{version}-macos-arm64-unsigned-beta.pkg",
      verified: "github.com/Taan-OSS/homebrew-midi-audio/"
  name "midi.audio"
  desc "Hosted MIDI-to-audio renderer with standalone, VST3 and Audio Unit clients"
  homepage "https://midi.audio/"

  depends_on arch: :arm64
  depends_on macos: ">= :ventura"

  pkg "midi-audio-#{version}-macos-arm64-unsigned-beta.pkg"

  uninstall pkgutil: "audio.midi.sur.bundle"

  caveats <<~EOS
    Close midi.audio and your DAWs before installing or upgrading.
    Read the terms before installation:
      https://github.com/Taan-OSS/homebrew-midi-audio/blob/main/collection-terms.html
    Rendering submits MIDI, instrument/settings and any supplied reference audio;
    these inputs are retained for model training under the installation terms.

    This beta is not Developer ID signed or notarized. Homebrew does not bypass
    Gatekeeper. If blocked, use System Settings > Privacy & Security > Open Anyway.
    Installation requires administrator authentication. Restart/rescan your DAW.
    Setup: https://github.com/Taan-OSS/homebrew-midi-audio#usage
  EOS
end
