class Kmonad < Formula
  desc "KMonad is an advanced tool that lets you infinitely customize and " \
         "extend the functionalities of almost any keyboard."
  homepage "http://github.com/kmonad/kmonad"
  url "https://github.com/kmonad/kmonad.git",
      revision: "7afe9e4ad49026d60b91c33289dcbe30e11054a8"
  version "20240113"
  license "MIT"

  depends_on macos: :big_sur
  depends_on "haskell-stack" => :build

  def install
    ghc_args = [
      "--flag",
      "kmonad:dext",
      "--extra-include-dirs=" \
        "c_src/mac/Karabiner-DriverKit-VirtualHIDDevice/include/pqrs/karabiner/driverkit:" \
        "c_src/mac/Karabiner-DriverKit-VirtualHIDDevice/src/Client/vendor/include"
    ]

    system "stack", "build", "--copy-bins", "--local-bin-path=#{bin}", *ghc_args
  end

  def post_install
    system "/usr/local/bin/brew", "cask", "install", "niklaas/kmonad/kmonad-karabiner-driverkit"
  end

  def uninstall
    system "rm", "-rf", "#{bin}/kmonad"
  end

  test do
    assert_match "an onion of buttons", shell_output("#{bin}/kmonad --help")
  end
end
