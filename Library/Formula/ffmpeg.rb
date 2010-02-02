require 'formula'

class Ffmpeg <Formula
  head 'svn://svn.ffmpeg.org/ffmpeg/trunk', :revisions => { :ffmpeg => 20701, :libswscale => 30381 }
  homepage 'http://ffmpeg.org/'

  def download_strategy; FfmpegSubversionDownloadStrategy end

  depends_on 'x264'

  def install
    configure_flags = [ "--prefix=#{prefix}",
                          "--disable-debug",
                          "--enable-nonfree",
                          "--enable-gpl",
                          "--enable-libx264"]
    system "./configure", *configure_flags
    system "make install"
  end

  class FfmpegSubversionDownloadStrategy <AbstractDownloadStrategy
    def initialize url, name, version, specs
      @name = name
      super url, name, version, specs
    end

    def fetch
      ohai "Checking out #{@url}"
      @co=HOMEBREW_CACHE+@unique_token
      unless @co.exist?
        quiet_safe_system svn, 'checkout', @url, @co
      else
        puts "Updating #{@co}"
        quiet_safe_system svn, 'up', @co
      end
    end

    def stage
      if @spec == :revision
        # Force the export, since the target directory will already exist
        args = [svn, 'export', '--force', @co, Dir.pwd]
        args << '-r' << @ref if @ref
        quiet_safe_system *args
      elsif @spec == :revisions
        @ref.each_pair do |directory, revision|
          if directory.to_s == @name
            directory = ''
          else
            directory = directory.to_s
          end
          # Force the export, since the target directory will already exist
          args = [svn, 'export', '--force', '--ignore-externals', @co + directory, Dir.pwd + '/' + directory]
          args << '-r' << revision
          quiet_safe_system *args
        end
      end
    end

    # Override this method in a DownloadStrategy to force the use of a non-
    # sysetm svn binary. mplayer.rb uses this to require a svn that
    # understands externals.
    def svn
      '/usr/bin/svn'
    end
  end
end
