class Buildmonitor < Formula
  desc "Desktop build monitor for GitHub Actions and Google Cloud"
  homepage "https://github.com/otto-ec/hamsterfish_x_build_monitor"
  url "https://github.com/IngmarStempellConsid/homebrew-hamsterfish_buildmonitor/releases/download/v0.1.2/buildmonitor-macos-universal.tar.gz"
  sha256 "023f70739821a23629fa6ae3bf3642195fe598f131d48c2a6e5464311e08e0e7"
  version "0.1.2"

  depends_on :macos

  def install
    libexec.install "buildmonitor"
    pkgshare.install "README.md"

    config_dir = etc/"buildmonitor"
    config_dir.install "workflows.txt" unless (config_dir/"workflows.txt").exist?
    config_dir.install "gcp-projects.txt" unless (config_dir/"gcp-projects.txt").exist?

    (bin/"buildmonitor").write <<~EOS
      #!/bin/bash
      cd "#{config_dir}"
      exec "#{libexec}/buildmonitor" "$@"
    EOS
  end

  def caveats
    <<~EOS
      Config files are installed to:
        #{etc}/buildmonitor/workflows.txt
        #{etc}/buildmonitor/gcp-projects.txt

      The launcher starts Build Monitor from that directory so the app can read them.
    EOS
  end
end
