set -x GOPATH $HOME/Dev/GOPATH
set -x PATH $GOPATH/bin $PATH
set -x PATH $HOME/.goenv/bin $PATH
goenv rehash >/dev/null ^&1
