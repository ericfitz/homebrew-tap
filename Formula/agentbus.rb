# Formula for agentbus — installs a prebuilt, signed, notarized universal binary.
# Rendered from release/agentbus.rb.tmpl by release/release.sh; do not edit
# the copy in the tap by hand.
class Agentbus < Formula
  desc "Local message bus and shared memory for coding agents"
  homepage "https://github.com/ericfitz/agentbus"
  url "https://github.com/ericfitz/agentbus/releases/download/v0.9.0/agentbus-v0.9.0-macos-universal.tar.gz"
  sha256 "ed1c8621b342175bb33b750b543081d33f8380eafb0ba6df7e7b88ec902a0ee9"
  license "Apache-2.0"

  # Prebuilt universal binary; no build dependencies. macOS only.
  depends_on :macos

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
