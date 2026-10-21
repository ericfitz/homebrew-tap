# Formula for brewsoak — installs a prebuilt, signed, notarized universal binary.
# Generated from this template by release/update-formula.sh (do not edit the
# rendered copy in the tap by hand; re-run update-formula.sh instead).
class Brewsoak < Formula
  desc "Homebrew wrapper that soaks formula and cask updates before installing them"
  homepage "https://github.com/ericfitz/brewsoakr"
  url "https://github.com/ericfitz/brewsoakr/releases/download/v1.6.0/brewsoak-v1.6.0-macos-universal.tar.gz"
  sha256 "8445db5d23d6224fd033a77701e27368e3c56b70a4a25ef6df800ab248a3a4e0"
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
