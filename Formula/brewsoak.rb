# Formula for brewsoak — installs a prebuilt, signed, notarized universal binary.
# Generated from this template by release/update-formula.sh (do not edit the
# rendered copy in the tap by hand; re-run update-formula.sh instead).
class Brewsoak < Formula
  desc "Homebrew wrapper that soaks formula and cask updates before installing them"
  homepage "https://github.com/ericfitz/brewsoakr"
  url "https://github.com/ericfitz/brewsoakr/releases/download/v1.2.0/brewsoak-v1.2.0-macos-universal.tar.gz"
  sha256 "9141bba6f25126d6d0fe8d7167fe5387dbe2dbfafe20bc995dfb94a5845209e0"
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
