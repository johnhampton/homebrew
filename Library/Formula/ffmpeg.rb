require 'formula'

class Ffmpeg <Formula
  head 'svn://svn.ffmpeg.org/ffmpeg/trunk', :revision => 20701
  homepage 'http://ffmpeg.org/'

  depends_on 'x264' => :optional
  depends_on 'faac' => :optional
  depends_on 'faad2' => :optional
  depends_on 'lame' => :optional

  def install
    configure_flags = [ "--prefix=#{prefix}",
                          "--disable-debug",
                          "--enable-nonfree",
                          "--enable-gpl"]
    
    configure_flags << ["--enable-libx264"] if Formula.factory('x264').installed?
    configure_flags << ["--enable-libfaac"] if Formula.factory('faac').installed?
    configure_flags << ["--enable-libfaad"] if Formula.factory('faad2').installed?
    configure_flags << ["--enable-libmp3lame"] if Formula.factory('lame').installed?
    
    system "./configure", *configure_flags
    system "make install"
  end
end
