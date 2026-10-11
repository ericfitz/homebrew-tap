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
    url "https://github.com/ericfitz/agentbus/releases/download/v1.14.3/agentbus-v1.14.3-macos-universal.tar.gz"
    sha256 "913795ed8fbb26a198a901e73b0d77b831953aa6d44cff36a3ecc296f48288d1"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/ericfitz/agentbus/releases/download/v1.14.3/agentbus-v1.14.3-linux-amd64.tar.gz"
    sha256 "34ce1e05760a1e35625d492a55b4df760ee9c3176f83537786047b46df4824a1"
  elsif OS.linux? && Hardware::CPU.arm?
    url "https://github.com/ericfitz/agentbus/releases/download/v1.14.3/agentbus-v1.14.3-linux-arm64.tar.gz"
    sha256 "9b930661c01ee461ecae4284e0806206c97dd9fdcb584ae0f665f45de51c1892"
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
