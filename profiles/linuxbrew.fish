if test (uname) = Linux
    # $HOME/.linuxbrew/bin/brew shellenv
    set -x HOMEBREW_PREFIX $HOME/.linuxbrew
    set -x HOMEBREW_CELLAR $HOME/.linuxbrew/Cellar
    set -x HOMEBREW_REPOSITORY $HOMEBREW_PREFIX
    fish_add_path -g $HOMEBREW_PREFIX/bin $HOMEBREW_PREFIX/sbin
    set -x MANPATH (brew --prefix)/share/man $MANPATH
    set -x INFOPATH (brew --prefix)/share/info $INFOPATH
end
