class Please < Formula
  desc "Interact with your terminal in natural language; all inference stays local."
  homepage "https://github.com/xhjkl/please"
  license "MIT"
  version "ci-20251121-154427-14160ca"

  livecheck do
    url :url
    strategy :github_latest
  end

  on_macos do
    on_arm do
      url "https://github.com/xhjkl/please/releases/download/#{version}/please-darwin-arm64", using: :nounzip
      sha256 "3d0335ecb66f9afe967f0ccb9a09af84ba8c4dbd5421efa4acc982db4df3de02"
    end

    on_intel do
      odie "Intel macOS is not supported."
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/xhjkl/please/releases/download/#{version}/please-linux-x86_64", using: :nounzip
      sha256 "fa39c603e86ff6544c968f453fc2a7bb8da8c8a4914fc0099f1ffbdfa771c136"
    end

    on_arm do
      url "https://github.com/xhjkl/please/releases/download/#{version}/please-linux-arm64", using: :nounzip
      sha256 "0e7f03911e9f3660bb90dc5c5026aa57e7a4f81d9b8683f0e98647beae32fe59"
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
