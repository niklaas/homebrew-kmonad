cask "kmonad-karabiner-elements-driverkit" do
  version "20240113"

  url "https://github.com/kmonad/kmonad.git",
      revision: "7afe9e4ad49026d60b91c33289dbe30e11054a8"
  name "Karabiner Elements DriverKit"
  desc "Virtual devices (keyboard and mouse) implementation for macOS using DriverKit."
  homepage "https://github.com/pqrs-org/Karabiner-DriverKit-VirtualHIDDevice"

  conflicts_with cask: ["karabiner-elements"]
  depends_on macos: ">= :big_sur"

  pkg "c_src/mac/Karabiner-DriverKit-VirtualHIDDevice/dist/Karabiner-DriverKit-VirtualHIDDevice-3.1.0.pkg"

  postflight do
    system "/Applications/.Karabiner-VirtualHIDDevice-Manager.app/Contents/MacOS/Karabiner-VirtualHIDDevice-Manager",
           "activate"
  end

  uninstall pkgutil: "org.pqrs.Karabiner-DriverKit-VirtualHIDDevice"

  def caveats
    <<~EOS
      Installing this cask conflicts with 'karabiner-elements' because it installs its own version of the DriverKit.
    EOS
  end
end
