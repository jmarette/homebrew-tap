class GitId < Formula
  desc "Manage Git identities and route them to directories via native conditional includes"
  homepage "https://github.com/jmarette/git-id"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jmarette/git-id/releases/download/v0.5.0/git-id-aarch64-apple-darwin.tar.xz"
      sha256 "cd42ee1b526f14ca6f07ead98a69ee404a127543cf6770aee6a6cfa6fae4b8d0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jmarette/git-id/releases/download/v0.5.0/git-id-x86_64-apple-darwin.tar.xz"
      sha256 "aa85b98647d2118c4b3af694073b063d01475095f813e8a515b89585f333062d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/jmarette/git-id/releases/download/v0.5.0/git-id-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "93aaf7b45302b36a0f8aa2ca253d71638c630a1b9a3de6a440915f4814ee9cf2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jmarette/git-id/releases/download/v0.5.0/git-id-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7d6e0579c324c3e64528f5571233fe33462d5eab78c036e938bae96bc72ac34d"
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
