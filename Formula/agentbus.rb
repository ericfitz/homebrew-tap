# Formula for agentbus — installs a prebuilt binary: a signed, notarized
# universal binary on macOS, a static binary on Linux (amd64 and arm64).
# Rendered from release/agentbus.rb.tmpl by release/release.sh; do not edit
# the copy in the tap by hand.
#
# The host checks below are the layout Homebrew accepts for third-party taps
# that ship platform-specific URLs: `url`/`sha256` are not allowed inside
# `on_macos`/`on_linux` blocks (FormulaAudit/ComponentsOrder), and the
# OnSystemConditionals cop exempts non-core taps from the on_* rewrite.
class Agentbus < Formula
  desc "Local message bus and shared memory for coding agents"
  homepage "https://github.com/ericfitz/agentbus"
  license "Apache-2.0"

  if OS.mac?
    url "https://github.com/ericfitz/agentbus/releases/download/v1.19.0/agentbus-v1.19.0-macos-universal.tar.gz"
    sha256 "84ed8e6ac19437b19eee05f0c40af3c96e2949a4dc83738cf2c3df71286e7d04"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/ericfitz/agentbus/releases/download/v1.19.0/agentbus-v1.19.0-linux-amd64.tar.gz"
    sha256 "c8e00392a86e34e68218c4e074b0b86896b62c999f9c9c659fefa31bca4fb105"
  elsif OS.linux? && Hardware::CPU.arm?
    url "https://github.com/ericfitz/agentbus/releases/download/v1.19.0/agentbus-v1.19.0-linux-arm64.tar.gz"
    sha256 "a119b54dc5231f66679509e37e4363b90eb38466d362c4fc4e51957a5f3e2b67"
  end

  def install
    bin.install "agentbus"
  end

  def caveats
    <<~EOS
      Register agentbus with your coding harnesses once per machine:
        agentbus init --global
      Then run `agentbus init` inside each repository.
    EOS
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/agentbus version").strip
  end
end
