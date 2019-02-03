if test (uname) = Linux
    # $HOME/.linuxbrew/bin/brew shellenv
    set -x HOMEBREW_PREFIX $HOME/.linuxbrew
    set -x HOMEBREW_CELLAR $HOME/.linuxbrew/Cellar
    set -x HOMEBREW_REPOSITORY $HOMEBREW_PREFIX
    set -x PATH $HOMEBREW_PREFIX/bin $HOMEBREW_PREFIX/sbin $PATH
    set -x MANPATH (brew --prefix)/share/man $MANPATH
    set -x INFOPATH (brew --prefix)/share/info $INFOPATH
end
