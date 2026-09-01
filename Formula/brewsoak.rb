# Formula for brewsoak — installs a prebuilt, signed, notarized universal binary.
# Generated from this template by release/update-formula.sh (do not edit the
# rendered copy in the tap by hand; re-run update-formula.sh instead).
class Brewsoak < Formula
  desc "Homebrew wrapper that soaks formula and cask updates before installing them"
  homepage "https://github.com/ericfitz/brewsoakr"
  url "https://github.com/ericfitz/brewsoakr/releases/download/v1.1.0/brewsoak-v1.1.0-macos-universal.tar.gz"
  sha256 "64f6be37af87b2e164016fc0d593bf11c7d31faf851228204c547f319a205f3b"
  license "Apache-2.0"

  # Prebuilt universal binary; no build dependencies. macOS only.
  depends_on :macos

  def install
    bin.install "brewsoak"
  end

  test do
    # --version does not shell out to brew, so it is safe in the sandbox.
    assert_match "brewsoak #{version}", shell_output("#{bin}/brewsoak --version")
    # help lists the soaked subcommands.
    assert_match "update, upgrade, install", shell_output("#{bin}/brewsoak --help")
  end
end
