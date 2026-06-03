class Please < Formula
  desc "Interact with your terminal in natural language; all inference stays local"
  homepage "https://github.com/xhjkl/please"
  license "MIT"
  version "ci-20260603-122009-ee51d0e"

  livecheck do
    url :url
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/xhjkl/please/releases/download/#{version}/please-darwin-arm64", using: :nounzip
      sha256 "b3262b6283bade761644793b14f93ef27863a97f79c8db48e5d76becc0576417"
    end

    on_intel do
      odie "Intel macOS is not supported."
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/xhjkl/please/releases/download/#{version}/please-linux-x86_64", using: :nounzip
      sha256 "8c3d705641ba40fed5aecd60ecba1837011b76604fb9cd14a7a3ed9e4d3f6429"
    end

    on_arm do
      url "https://github.com/xhjkl/please/releases/download/#{version}/please-linux-arm64", using: :nounzip
      sha256 "a74b1aab60d424115cc9f5356a7d46a6f03957a28e10090cdfe88c70f2b3948e"
    end
  end

  def install
    src = Dir["please*", "*please*"].first
    raise "unexpected asset layout" unless src && File.file?(src)
    chmod 0555, src
    bin.install src => "please"
  end

  # Print guidance at install & via `brew info`
  def caveats
    <<~EOS
      Weights are stored outside Homebrew at `~/.please/weights`

      To remove downloaded weights:
        rm -rf ~/.please/weights

      To uninstall the CLI itself:
        brew uninstall xhjkl/made/please
    EOS
  end

  test do
    # smoke test: should print help/usage without crashing
    assert_match(/please/i, shell_output("#{bin}/please --help 2>&1"))
  end
end
