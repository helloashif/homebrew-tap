cask "ip-tracker" do
  version "0.1.2"
  sha256 "66a42502b6df8e95826028d0be9ea3ae0de16530c1589c30678a100ed25d18c6"

  url "https://github.com/helloashif/ip-tracker-desktop/releases/download/v#{version}/IP.Tracker_#{version}_aarch64.dmg"
  name "IP Tracker"
  desc "Track your public IP address over time"
  homepage "https://github.com/helloashif/ip-tracker-desktop"

  livecheck do
    url :url
    strategy :github_latest
  end

  # Only an Apple Silicon build is published for now.
  depends_on arch: :arm64
  depends_on macos: ">= :catalina"

  app "IP Tracker.app"

  # The app is not notarized yet; clear the quarantine flag so Gatekeeper
  # doesn't report it as damaged.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-cr", "#{appdir}/IP Tracker.app"],
                   sudo: false
  end

  zap trash: [
    "~/Library/Application Support/dev.ashif.iptracker",
    "~/Library/Caches/dev.ashif.iptracker",
    "~/Library/LaunchAgents/IP Tracker.plist",
    "~/Library/Preferences/dev.ashif.iptracker.plist",
    "~/Library/Saved Application State/dev.ashif.iptracker.savedState",
    "~/Library/WebKit/dev.ashif.iptracker",
  ]
end
