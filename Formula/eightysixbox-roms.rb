class EightysixboxRoms < Formula
  desc "ROMs for the 86Box emulator"
  homepage "https://github.com/86Box/roms"
  url "https://github.com/86Box/roms/archive/refs/tags/20220216.tar.gz"
  sha256 "d4c13ffca2822c47ec443475b39dc7c700bf17d869d90183b96623ffac35d27f"
  license ""

  bottle do
    root_url "https://github.com/Zi0P4tch0/homebrew-taps/releases/download/eightysixbox-roms-20220216"
    sha256 cellar: :any_skip_relocation, big_sur:      "cf246d1a3b382268e96fcb8d899fbccd2b0da15fc7ae9b5ffc88772d1dbf7d37"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "b397df6ee0fbc5812a80d870d09ea1a536fb7c1c2fc65b9446cf446461be2fe9"
  end

  def install
    prefix.install Dir["*"]
  end

  test do
    # Check if folder "floppy" exists
    assert_predicate prefix/"floppy", :exist?
  end
end
