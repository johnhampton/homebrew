require 'formula'

class Pbzip2 <Formula
  url 'http://compression.ca/pbzip2/pbzip2-1.0.5.tar.gz'
  homepage 'http://compression.ca/pbzip2/'
  md5 'e2448d22ee29d1e6549ac58b98df11ab'

  

  def install
    inreplace "Makefile", /^CC = .*$/, ""
    inreplace "Makefile", /^CFLAGS = .*$/, ""
    inreplace "Makefile", "-pthread -lpthread", "" 
    inreplace "Makefile", /^PREFIX = .*$/, "PREFIX = #{prefix}"
    inreplace "Makefile", "man/man1", "share/man/man1"
    inreplace "Makefile", "$(CC)", "$(CXX)"
    
    system "make install"
  end
end
