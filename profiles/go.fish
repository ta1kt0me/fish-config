if test -z "$GOENV_ROOT"
  set -x GOENV_ROOT $HOME/.goenv
  fish_add_path -g $GOENV_ROOT/bin
  string replace -a 'setenv' 'set -x' (goenv init -) | source
  fish_add_path -g $GOPATH/bin
end
