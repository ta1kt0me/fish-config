set -x GOENV_ROOT $HOME/.goenv
set -x PATH $GOENV_ROOT/bin $PATH
string replace -a 'setenv' 'set -x' (goenv init -) | source
set -x PATH $GOPATH/bin $PATH

# direnv
type -f direnv > /dev/null

if test $status -eq 0
    eval (direnv hook fish)
end
