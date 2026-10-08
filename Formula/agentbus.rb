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
    url "https://github.com/ericfitz/agentbus/releases/download/v1.14.2/agentbus-v1.14.2-macos-universal.tar.gz"
    sha256 "c24b512ad5fceecad3bd7d8b9e7c3b9d8eafcfaee3a5fc27faf0e14be7503522"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/ericfitz/agentbus/releases/download/v1.14.2/agentbus-v1.14.2-linux-amd64.tar.gz"
    sha256 "92ac641bcaa8b80403b285f80cc4ea8784eeb8afebe1325287fb9419fca10acb"
  elsif OS.linux? && Hardware::CPU.arm?
    url "https://github.com/ericfitz/agentbus/releases/download/v1.14.2/agentbus-v1.14.2-linux-arm64.tar.gz"
    sha256 "85f5a008459c2bb01f8c022b3bfd6e37f66675ddb1cacdd2ec4e4e3ebd31fa85"
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
