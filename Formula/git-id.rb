class GitId < Formula
  desc "Manage Git identities and route them to directories via native conditional includes"
  homepage "https://github.com/jmarette/git-id"
  version "0.4.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jmarette/git-id/releases/download/v0.4.1/git-id-aarch64-apple-darwin.tar.xz"
      sha256 "af931e54630f19fa41395365b96f695ae7220ec70820930c73cf9cd2ff3674fa"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jmarette/git-id/releases/download/v0.4.1/git-id-x86_64-apple-darwin.tar.xz"
      sha256 "102ce51863be1287748ef5290dbeb1397be3874638b767e6367c842f9ad8efce"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/jmarette/git-id/releases/download/v0.4.1/git-id-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "dad6b52cec5a47295cec2d1e75b8ed4f3e7edea4507525a9a425352e885b96fd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jmarette/git-id/releases/download/v0.4.1/git-id-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0fa2b7bbe94ddabdcf7768607d0478a714f5bd16305def52e747b6f3851544fd"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "git-id" if OS.mac? && Hardware::CPU.arm?
    bin.install "git-id" if OS.mac? && Hardware::CPU.intel?
    bin.install "git-id" if OS.linux? && Hardware::CPU.arm?
    bin.install "git-id" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
