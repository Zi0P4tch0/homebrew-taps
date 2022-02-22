class EightysixboxRoms < Formula
  desc "ROMs for the 86Box emulator"
  homepage "https://github.com/86Box/roms"
  url "https://github.com/86Box/roms/archive/refs/tags/20220216.tar.gz"
  sha256 "d4c13ffca2822c47ec443475b39dc7c700bf17d869d90183b96623ffac35d27f"
  license ""

  def install
    prefix.install Dir["*"]
  end

  test do
    # Check if folder "floppy" exists
    assert_predicate prefix/"floppy", :exist?
  end
end
