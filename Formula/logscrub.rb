class Logscrub < Formula
  desc "Mask secrets and personal data in logs so they can be shared safely"
  homepage "https://github.com/hbenali/logscrub"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/hbenali/logscrub/releases/download/1.1.1/logscrub_1.1.1_darwin_arm64.tar.gz"
      sha256 "7bb0a260cf1ae7ad60ab5294378930bf316ad266c3326fcd563829f33ca9a24e"
    end
    on_intel do
      url "https://github.com/hbenali/logscrub/releases/download/1.1.1/logscrub_1.1.1_darwin_amd64.tar.gz"
      sha256 "c56994490db2ca70297deef32ab3d2515e2a5e2ebb4859c7653f588191dd9ae4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/hbenali/logscrub/releases/download/1.1.1/logscrub_1.1.1_linux_arm64.tar.gz"
      sha256 "2b033d80ac38a4c1a3c6d7ec85ffb84b5857f1c9bc0a909597bd4ebe528fd068"
    end
    on_intel do
      url "https://github.com/hbenali/logscrub/releases/download/1.1.1/logscrub_1.1.1_linux_amd64.tar.gz"
      sha256 "be2036906cbba95bcc618d830c6e0d78e8a4f9a00f6a339cfb9fc700bc654460"
    end
  end

  def install
    bin.install "logscrub"
    man1.install "logscrub.1"
    bash_completion.install "completions/logscrub.bash" => "logscrub"
    zsh_completion.install "completions/_logscrub"
    fish_completion.install "completions/logscrub.fish"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/logscrub --version")
    assert_equal "password=[REDACTED:kv-secret]\n", pipe_output(bin/"logscrub", "password=hunter2\n")
    assert_match "REDACTED:email", pipe_output(bin/"logscrub", "bob@example.org\n")
  end
end
