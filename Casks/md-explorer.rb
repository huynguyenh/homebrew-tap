cask "md-explorer" do
  arch arm: "arm64", intel: "x64"

  version "1.0.0"
  sha256 arm:   "eabcb52bc788c2b8a7f7307e217fc8ec1778108f61391e6b7ddd8969c26e9164",
         intel: "6431bbe980b1d5bbe0ab52f5b5336e9a0ac49cc28e8e4608a2dae38126e5acd1"

  url "https://github.com/huynguyenh/md-explorer/releases/download/v#{version}/MD-Explorer-#{version}-#{arch}.zip"
  name "MD Explorer"
  desc "Finder-style markdown explorer and reader"
  homepage "https://github.com/huynguyenh/md-explorer"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :monterey

  app "MD Explorer.app"
  binary "#{appdir}/MD Explorer.app/Contents/Resources/bin/md-explorer"

  # The app is ad-hoc signed, not notarized. Clear the download quarantine flag
  # so macOS opens it without the "cannot verify developer" block.
  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "/Applications/MD Explorer.app"],
        must_succeed: false
  end

  zap trash: [
    "~/Library/Application Support/md-explorer",
    "~/Library/Preferences/com.huynguyenh.mdexplorer.plist",
    "~/Library/Saved Application State/com.huynguyenh.mdexplorer.savedState",
  ]
end
