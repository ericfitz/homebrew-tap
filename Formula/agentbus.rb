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
    url "https://github.com/ericfitz/agentbus/releases/download/v1.18.0/agentbus-v1.18.0-macos-universal.tar.gz"
    sha256 "88340b76828ac09d6329066d86eeedca1d202376d9eaf94141b833913da0820e"
  elsif OS.linux? && Hardware::CPU.intel?
    url "https://github.com/ericfitz/agentbus/releases/download/v1.18.0/agentbus-v1.18.0-linux-amd64.tar.gz"
    sha256 "8be38a75da8288e980ed18c892cf5e8f9a9607d2c708f195059046bea274037d"
  elsif OS.linux? && Hardware::CPU.arm?
    url "https://github.com/ericfitz/agentbus/releases/download/v1.18.0/agentbus-v1.18.0-linux-arm64.tar.gz"
    sha256 "e31111838c2dde3d1884f3e2c9b1bc1e5222a6fcb9634ab99da072002afb561a"
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
