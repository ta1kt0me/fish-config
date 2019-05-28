set -x GOENV_DISABLE_GOPATH 1
set -x GOPATH $HOME/src
set -x GOENV_ROOT $HOME/.goenv
set -x PATH $GOENV_ROOT/bin $PATH
set -x PATH $GOPATH/bin $PATH
string replace -a 'setenv' 'set -x' (goenv init -) | source

# direnv
eval (direnv hook fish)
