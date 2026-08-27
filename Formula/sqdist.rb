# Formula for sqdist — installs a prebuilt, signed, notarized universal binary.
# Generated from this template by release/update-formula.sh (do not edit the
# rendered copy in the tap by hand; re-run update-formula.sh instead).
class Sqdist < Formula
  desc "Fast string-distance CLI for typosquatting and homoglyph detection"
  homepage "https://github.com/ericfitz/sqdist"
  url "https://github.com/ericfitz/sqdist/releases/download/v0.5.0/sqdist-v0.5.0-macos-universal.tar.gz"
  version "0.5.0"
  sha256 "cc242eb252d6d7d393e8c1760e22e27efe1639c70aa16608150542749b2e33c5"
  license any_of: ["MIT", "Apache-2.0"]

  # Prebuilt universal binary; no build dependencies. macOS only.
  depends_on :macos

  def install
    bin.install "sqdist"
  end

  test do
    # Assert against JSON output (stable keys) rather than human-column spacing.
    # Identical strings => zero distance.
    assert_match '"levenshtein":0', shell_output("#{bin}/sqdist -j abc abc")
    # Cyrillic homoglyph spoof is flagged confusable_only=true.
    assert_match '"confusable_only":true',
                 shell_output("#{bin}/sqdist -j paypal pаypal")
  end
end
