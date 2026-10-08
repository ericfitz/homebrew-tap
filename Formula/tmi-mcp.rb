# Formula for tmi-mcp — installs a prebuilt, signed, notarized universal binary.
# Rendered from release/tmi-mcp.rb.tmpl by release/release.sh; do not edit
# the copy in the tap by hand.
class TmiMcp < Formula
  desc "MCP server for threat modeling against a TMI server"
  homepage "https://github.com/ericfitz/tmi-mcp"
  url "https://github.com/ericfitz/tmi-mcp/releases/download/v1.0.2/tmi-mcp-v1.0.2-macos-universal.tar.gz"
  sha256 "9fafebbad26601d7d2a3bde97cb18767867e384cbf8e80b0a5bd166072427363"
  license "Apache-2.0"

  # Prebuilt universal binary; no build dependencies. macOS only.
  depends_on :macos

  def install
    bin.install "tmi-mcp"
  end

  def caveats
    <<~EOS
      Register tmi-mcp with your coding harnesses:
        tmi-mcp init
      Then create ~/.config/tmi-mcp/config.yaml (init prints a sample).
    EOS
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/tmi-mcp version").strip
  end
end
