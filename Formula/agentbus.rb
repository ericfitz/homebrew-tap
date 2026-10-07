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
    url "https://github.com/ericfitz/agentbus/releases/download/v1.14.1/agentbus-v1.14.1-macos-universal.tar.gz"
    sha256 "c3cb33790a3a4de5c1dbc51fb54e3694f80b4e90afe91fcd51ed1524ce46163d"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/ericfitz/agentbus/releases/download/v1.14.1/agentbus-v1.14.1-linux-amd64.tar.gz"
    sha256 "cf9c73f1db00f829d1fc80332214da444ffabfa24d9d81ae45b781d7b4f2665a"
  elsif OS.linux? && Hardware::CPU.arm?
    url "https://github.com/ericfitz/agentbus/releases/download/v1.14.1/agentbus-v1.14.1-linux-arm64.tar.gz"
    sha256 "623f1ee7060bfb030ec9a93a57c0c3658f64fc44ce68881516362677cfce5e72"
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
