class Openagent < Formula
  desc "Open-source agentic coding CLI — multi-provider, token-efficient, extensible"
  homepage "https://github.com/ask-sol/openagent"
  url "https://github.com/ask-sol/openagent.git",
    branch: "main"
  version "0.1.30-20260418"
  license "MIT"
  head "https://github.com/ask-sol/openagent.git", branch: "main"

  depends_on "node@20"

  def install
    system "npm", "install", *std_npm_args
    system "npm", "install", "tsx"

    libexec.install Dir["*"] - Dir["bin"]

    (bin/"openagent").write <<~SH
      #!/bin/bash
      exec "#{libexec}/node_modules/.bin/tsx" "#{libexec}/src/entrypoints/cli.tsx" "$@"
    SH
  end

  test do
    assert_match "0.1.", shell_output("#{bin}/openagent --version")
  end
end
