cask "openwith-app" do
  version "0.1.0"
  sha256 "a1927913a2d0937f9b263e5662f22af2a4c021b3b944f8f2f1983891149ca8de"

  url "https://github.com/jmarette/openwith/releases/download/v#{version}/OpenWith-#{version}.dmg"
  name "OpenWith"
  desc "GUI for managing macOS default applications"
  homepage "https://github.com/jmarette/openwith"

  depends_on macos: ">= :sequoia"

  app "OpenWith.app"

  caveats <<~EOS
    OpenWith.app is not notarized (the project has no Apple Developer
    account). On first launch macOS will refuse to open it; either
    right-click the app in Finder and choose Open, or clear the quarantine
    attribute:

      xattr -dr com.apple.quarantine /Applications/OpenWith.app
  EOS
end
