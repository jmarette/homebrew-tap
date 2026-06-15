class GitId < Formula
  desc "Manage Git identities and route them to directories via native conditional includes"
  homepage "https://github.com/jmarette/git-id"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jmarette/git-id/releases/download/v0.4.0/git-id-aarch64-apple-darwin.tar.xz"
      sha256 "c0ab0ea0dfb705c210477bd978e9a73415c21278c185fa6e38ca8d7dc80a8b00"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jmarette/git-id/releases/download/v0.4.0/git-id-x86_64-apple-darwin.tar.xz"
      sha256 "322724a381dd70a5bef715c47035b352f0daecdc48a14f3c9ec84b1af6801ad5"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/jmarette/git-id/releases/download/v0.4.0/git-id-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9a105d7dc0332b3c4ed339bcfe626589258daa092451a5f4eb501cbc8d5842cc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jmarette/git-id/releases/download/v0.4.0/git-id-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "17a5ce634285b4a48eafced85d9d807e38bf49cf15dfd018e49be794a21ca680"
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
