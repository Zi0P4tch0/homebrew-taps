class Eightysixbox < Formula
  desc "Emulator of x86-based machines based on PCem"
  homepage "https://86box.net/"
  url "https://github.com/86Box/86Box/archive/refs/tags/v3.2.1.tar.gz"
  sha256 "f7df87b4076fbdad2dccc2e26074f54f3b6f1f66e51b41b31ba9c206048ae5df"
  license "GPL-2.0-or-later"

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
    system "86Box", "--help"
  end
end
