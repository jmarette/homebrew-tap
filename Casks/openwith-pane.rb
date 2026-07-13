cask "openwith-pane" do
  version "0.1.0"
  sha256 "a4b4fb002aa0975a71a1206a5bcc6d0c7f003742dbbaaa04e8d4b3dcd04e441b"

  url "https://github.com/jmarette/openwith/releases/download/v#{version}/OpenWith-Pane-#{version}.zip"
  name "OpenWith PrefPane"
  desc "System Settings pane for managing macOS default applications (backup UI)"
  homepage "https://github.com/jmarette/openwith"

  depends_on macos: :sequoia

  prefpane "OpenWithPane.prefPane"

  caveats <<~EOS
    The pane is not notarized (the project has no Apple Developer account).
    If System Settings refuses to load it, clear the quarantine attribute:

      xattr -dr com.apple.quarantine ~/Library/PreferencePanes/OpenWithPane.prefPane

    Third-party panes appear at the bottom of the System Settings sidebar,
    and macOS asks for an approval on first open.
  EOS
end
