set -x GOPATH $HOME/src
set -x GOBIN $GOPATH/bin
set -x PATH $GOBIN $PATH
set -x GOENV_ROOT $HOME/.goenv
set -x PATH $GOENV_ROOT/bin $PATH
goenv rehash >/dev/null ^&1

# direnv
eval (direnv hook fish)
