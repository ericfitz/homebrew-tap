# Formula for sqdist — installs a prebuilt, signed, notarized universal binary.
# Generated from homoglyph-dist/release/homebrew/sqdist.rb.tmpl by update-formula.sh.
class Sqdist < Formula
  desc "Fast string-distance CLI for typosquatting and homoglyph detection"
  homepage "https://github.com/ericfitz/homoglyph-dist"
  url "https://github.com/ericfitz/homoglyph-dist/releases/download/v0.1.0/sqdist-v0.1.0-macos-universal.tar.gz"
  version "0.1.0"
  sha256 "13deb2cd3a0f13ef9a82dffad28c29dc6d7af0f305808b70c94c637179921e56"
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
