class Please < Formula
  desc "Interact with your terminal in natural language; all inference stays local"
  homepage "https://github.com/xhjkl/please"
  license "MIT"
  version "2611.22"

  livecheck do
    url :url
    regex(/\A(\d{4}\.[1-9]\d*)\z/)
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/xhjkl/please/releases/download/#{version}/please-darwin-arm64", using: :nounzip
      sha256 "cd97d05fe363d19e03547ddcebadd85222eef92ba66041ec2f48f6eb55e4d271"
    end

    on_intel do
      odie "Intel macOS is not supported."
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/xhjkl/please/releases/download/#{version}/please-linux-x86_64", using: :nounzip
      sha256 "97f79a081b2794decd66c0549ba651ede2a103a84e2b06ce0851e37073f62c1c"
    end

    on_arm do
      url "https://github.com/xhjkl/please/releases/download/#{version}/please-linux-arm64", using: :nounzip
      sha256 "3ea1fb1e1a635b197a78eb0e1483ed738a8b8bb19804e527c1739bf4cb60ffd2"
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
