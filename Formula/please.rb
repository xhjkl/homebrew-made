class Please < Formula
  desc "Interact with your terminal in natural language; all inference stays local"
  homepage "https://github.com/xhjkl/please"
  license "MIT"
  version "ci-20260604-090953-d827bf9"

  livecheck do
    url :url
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/xhjkl/please/releases/download/#{version}/please-darwin-arm64", using: :nounzip
      sha256 "4aa9a84d0632704125a3188cd2d46ea11573e8661ee79ee43870a367ffbb2277"
    end

    on_intel do
      odie "Intel macOS is not supported."
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/xhjkl/please/releases/download/#{version}/please-linux-x86_64", using: :nounzip
      sha256 "aa45f6df41d1d555bda6206292649e7aaa0d5888344babcadbb08f45cb77fc2c"
    end

    on_arm do
      url "https://github.com/xhjkl/please/releases/download/#{version}/please-linux-arm64", using: :nounzip
      sha256 "edbea1454418be6ea6ce17b562d4df24cc714bfd11fd7d6df191714df0774e0b"
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
