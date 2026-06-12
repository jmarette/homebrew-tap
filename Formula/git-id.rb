class GitId < Formula
  desc "Manage Git identities and route them to directories via conditional includes"
  homepage "https://github.com/jmarette/git-id"
  url "https://github.com/jmarette/git-id/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "a686cd2a3c9de405f814a71a932c575f8ef9c39a1a4d5510c9a234009395351d"
  license any_of: ["MIT", "Apache-2.0"]
  head "https://github.com/jmarette/git-id.git", branch: "master"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
    generate_completions_from_executable(bin/"git-id", "completions")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/git-id --version")

    # Full workflow inside the sandboxed test HOME.
    ENV["HOME"] = testpath.to_s
    ENV["XDG_CONFIG_HOME"] = (testpath/".config").to_s
    system bin/"git-id", "init", "--no-use-config-only"
    system bin/"git-id", "create", "demo", "--name", "Demo User", "--email", "demo@tap.example"
    system bin/"git-id", "use", "demo", (testpath/"dev").to_s
    system bin/"git-id", "which", (testpath/"dev").to_s
    assert_match "demo@tap.example", shell_output("#{bin}/git-id show demo")
  end
end
