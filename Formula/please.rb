class Please < Formula
  desc "Interact with your terminal in natural language; all inference stays local"
  homepage "https://github.com/xhjkl/please"
  license "MIT"
  version "2611.1"

  livecheck do
    url :url
    regex(/\Av(\d{4}\.[1-9]\d*)\z/)
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/xhjkl/please/releases/download/v#{version}/please-darwin-arm64", using: :nounzip
      sha256 "237b94631776fef17b1bc6f6d8be4739f1fc4d75a90a28108a14f3fb4e581150"
    end

    on_intel do
      odie "Intel macOS is not supported."
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/xhjkl/please/releases/download/v#{version}/please-linux-x86_64", using: :nounzip
      sha256 "eb4ee1f6bed687285647d71906ba749f15774c856fe4f31077d07684ce896813"
    end

    on_arm do
      url "https://github.com/xhjkl/please/releases/download/v#{version}/please-linux-arm64", using: :nounzip
      sha256 "8fbb3ce93b3dddeb710f2f6d6abcd45abcf637ada359af19373b531e587efd13"
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
