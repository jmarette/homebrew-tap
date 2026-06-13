class GitId < Formula
  desc "Manage Git identities and route them to directories via native conditional includes"
  homepage "https://github.com/jmarette/git-id"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jmarette/git-id/releases/download/v0.2.0/git-id-aarch64-apple-darwin.tar.xz"
      sha256 "87d3d4dcbe7b27c1c0f754643cc81ba223088f5dd06f65868e70bc0cb48a1cac"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jmarette/git-id/releases/download/v0.2.0/git-id-x86_64-apple-darwin.tar.xz"
      sha256 "abf381dff9b671203ff2ec8dfa939b38ca4dcb3ad67552daa9b7fcd9b9bbb876"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/jmarette/git-id/releases/download/v0.2.0/git-id-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "11789e65f17f9018fabe3676ea45376bcf907aa42b1fa0027394e433b6269199"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jmarette/git-id/releases/download/v0.2.0/git-id-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a0bec6b189ac01b12dab17a6a333b9ea8d447d696f6f63e32dc73f628932d222"
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
