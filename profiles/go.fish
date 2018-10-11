set -x GOPATH $HOME/src
set -x GOBIN $GOPATH/bin
set -x PATH $GOBIN $PATH
set -x GOENV_ROOT $HOME/.goenv
set -x PATH $GOENV_ROOT/bin $PATH
goenv rehash >/dev/null ^&1
string replace -a 'setenv' 'set -x' (goenv init -) | source

# direnv
eval (direnv hook fish)
