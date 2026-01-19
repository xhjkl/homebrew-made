class Please < Formula
  desc "Interact with your terminal in natural language; all inference stays local"
  homepage "https://github.com/xhjkl/please"
  license "MIT"
  version "ci-20260119-161649-bb5a433"

  livecheck do
    url :url
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/xhjkl/please/releases/download/#{version}/please-darwin-arm64", using: :nounzip
      sha256 "8f16b26e04cd509285d6bd01251579294a187c2f26a66cfd9376e880e8e26ec8"
    end

    on_intel do
      odie "Intel macOS is not supported."
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/xhjkl/please/releases/download/#{version}/please-linux-x86_64", using: :nounzip
      sha256 "300dbe6597b3ca18635b3101f85af2d570698dcb005052654dbc96dd56586b04"
    end

    on_arm do
      url "https://github.com/xhjkl/please/releases/download/#{version}/please-linux-arm64", using: :nounzip
      sha256 "7956189eada2e67fc2a37e0d46fb5f6e716074e83d531b7547ebcb486565892e"
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
