require 'formula'

class TmuxMacosxPasteboard < Formula
  head 'https://github.com/ChrisJohnsen/tmux-MacOSX-pasteboard.git'
  homepage 'https://github.com/ChrisJohnsen/tmux-MacOSX-pasteboard'
  md5 'e2f11254fd663415bf44ad0969a96fb2'

  def install
    system "make"
    bin.install('reattach-to-user-namespace')
  end
end
