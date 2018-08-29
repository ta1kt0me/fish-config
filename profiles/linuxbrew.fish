if test (uname) = Linux
    set -x PATH $HOME/.linuxbrew/bin $PATH
    set -x MANPATH (brew --prefix)/share/man $MANPATH
    set -x INFOPATH (brew --prefix)/share/info $INFOPATH
end
