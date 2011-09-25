require 'formula'

class KnifeBashCompletion < Formula
  homepage 'https://gist.github.com/1050685'
  head 'git://gist.github.com/1050685.git'

  def install
    (prefix+'etc/bash_completion.d').install 'knife'
  end
end
