# Formula for sqdist — installs a prebuilt, signed, notarized universal binary.
# Generated from this template by release/update-formula.sh (do not edit the
# rendered copy in the tap by hand; re-run update-formula.sh instead).
class Sqdist < Formula
  desc "Fast string-distance CLI for typosquatting and homoglyph detection"
  homepage "https://github.com/ericfitz/sqdist"
  url "https://github.com/ericfitz/homoglyph-dist/releases/download/v0.3.0/sqdist-v0.3.0-macos-universal.tar.gz"
  version "0.3.0"
  sha256 "a5c6343783b6b0dd262ab9b68c9bb39ced17bb64996c09c85f8b592ee66796b2"
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
