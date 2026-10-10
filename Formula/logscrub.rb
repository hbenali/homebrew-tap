class Logscrub < Formula
  desc "Mask secrets and personal data in logs so they can be shared safely"
  homepage "https://github.com/hbenali/logscrub"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/hbenali/logscrub/releases/download/1.1.0/logscrub_1.1.0_darwin_arm64.tar.gz"
      sha256 "7764f18615a39d247ffea11365f7e877f299c0b751c123ffc617a8eec82c83b8"
    end
    on_intel do
      url "https://github.com/hbenali/logscrub/releases/download/1.1.0/logscrub_1.1.0_darwin_amd64.tar.gz"
      sha256 "7eb3594cded3243c3c7ae2d0d18e3496d66c8104e2ab9c22921430650fd5ab05"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/hbenali/logscrub/releases/download/1.1.0/logscrub_1.1.0_linux_arm64.tar.gz"
      sha256 "b4afbc5875349799d08dea068a315d4b606a5250194b45fc8671972e4852b6a9"
    end
    on_intel do
      url "https://github.com/hbenali/logscrub/releases/download/1.1.0/logscrub_1.1.0_linux_amd64.tar.gz"
      sha256 "9be8434381e328407254b458dc7b75af8d849a3bd03190ede2c34a8f95e5cd1c"
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
