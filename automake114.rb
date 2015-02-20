require 'formula'

class Automake114 < Formula
  homepage 'https://www.gnu.org/software/automake/'
  url 'http://ftpmirror.gnu.org/automake/automake-1.14.1.tar.gz'
  mirror 'https://ftp.gnu.org/gnu/automake/automake-1.14.1.tar.gz'
  sha1 '0bb1714b78d70cab9907d2013082978a28f48a46'

  depends_on 'autoconf' => :run

  keg_only "Conflicts with current automake version"

  def install
    system "./configure", "--prefix=#{prefix}", "--program-suffix=-1.14"
    system "make install"

    # Our aclocal must go first. See:
    # https://github.com/mxcl/homebrew/issues/10618
    (share/"aclocal/dirlist").write <<-EOS.undent
      #{HOMEBREW_PREFIX}/share/aclocal
      /usr/share/aclocal
    EOS
  end

  test do
    system "#{bin}/automake-1.14", "--version"
  end
end
