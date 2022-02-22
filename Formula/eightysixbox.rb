class Eightysixbox < Formula
  desc "Emulator of x86-based machines based on PCem"
  homepage "https://86box.net/"
  url "https://github.com/86Box/86Box/archive/refs/tags/v3.2.1.tar.gz"
  sha256 "f7df87b4076fbdad2dccc2e26074f54f3b6f1f66e51b41b31ba9c206048ae5df"
  license "GPL-2.0-or-later"

  bottle do
    root_url "https://github.com/Zi0P4tch0/homebrew-taps/releases/download/eightysixbox-3.2.1"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "043fd087e77038aa1d4c937442d922c98bf640d72d68e1300a1fef837d8cc8fe"
    sha256 cellar: :any,                 big_sur:        "f68d332cb56e4f5285c8c7cd1325ec49a0b617ee0f39cf854259852e7fde2c3f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "74fffb57d29cef18ab6258ab73e09ab142d3ce8f13b6eb4a0ff383ca584cc31a"
  end

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on xcode: :build

  depends_on "faudio"
  depends_on "freetype"
  depends_on "qt@5"
  depends_on "rtmidi"
  depends_on "sdl2"

  on_linux do
    depends_on "openal-soft"
  end

  def install
    system "cmake", "-S", ".", "-B", "build",
                    "-DQt5_DIR=#{Formula["qt@5"].lib}/cmake/Qt5",
                    "-DQt5LinguistTools_DIR=#{Formula["qt@5"].lib}/cmake/Qt5LinguistTools",
                    (Hardware::CPU.arm? ? "-DDYNAREC=OFF" : ""),
                    (OS.mac? ? "-DCMAKE_MACOSX_BUNDLE=OFF" : ""),
                    *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  def caveats
    s = <<~EOS
      Download the latest roms from https://github.com/86Box/roms/releases and unpack them in a convenient location.

      The ROMS path can be adjusted with the "-r" flag.

      e.g. if you put the roms in "~/86box-roms", you would start 86Box like this:

      86Box -r "~/86box-roms"

    EOS

    if Hardware::CPU.arm?
      s += <<~EOS
        Note: This version of 86Box doesn't support DYNAREC (unsupported architecture).
      EOS
    end

    s
  end

  test do
    # Test disabled as the app requires a display.
    system "true"
  end
end
