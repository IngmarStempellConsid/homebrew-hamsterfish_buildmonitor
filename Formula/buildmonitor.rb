class Buildmonitor < Formula
  desc "Desktop build monitor for GitHub Actions and Google Cloud"
  homepage "https://github.com/otto-ec/hamsterfish_x_build_monitor"
  url "https://github.com/IngmarStempellConsid/homebrew-hamsterfish_buildmonitor/releases/download/v0.1.3/buildmonitor-macos-universal.tar.gz"
  sha256 "0d6f6787e69ca4754e3c2ee3b96ee17d27c84ba1273b3a03dca61d4687fb376a"
  version "0.1.3"

  depends_on :macos

  def install
    libexec.install "buildmonitor"
    libexec.install "metric-url-converter"
    pkgshare.install "README.md"

    config_dir = etc/"buildmonitor"
    config_dir.install "workflows.txt" unless (config_dir/"workflows.txt").exist?
    config_dir.install "gcp-projects.txt" unless (config_dir/"gcp-projects.txt").exist?
    config_dir.install "metrics.txt" unless (config_dir/"metrics.txt").exist?

    (bin/"buildmonitor").write <<~EOS
      #!/bin/bash
      cd "#{config_dir}"
      exec "#{libexec}/buildmonitor" "$@"
    EOS

    (bin/"metric-url-converter").write <<~EOS
      #!/bin/bash
      cd "#{config_dir}"
      exec "#{libexec}/metric-url-converter" "$@"
    EOS
  end

  def caveats
    <<~EOS
      Config files are installed to:
        #{etc}/buildmonitor/workflows.txt
        #{etc}/buildmonitor/gcp-projects.txt
        #{etc}/buildmonitor/metrics.txt
        #{etc}/buildmonitor/user-settings.json

      The launcher starts Build Monitor from that directory so the app can read them.
      user-settings.json is created automatically when UI settings are changed.
      metric-url-converter can append Metrics Explorer URLs to metrics.txt from the same directory.
    EOS
  end
end
