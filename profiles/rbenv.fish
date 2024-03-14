if test -z "$RBENV_ROOT"
    set -x RBENV_ROOT $HOME/.rbenv
    fish_add_path -g $RBENV_ROOT/bin
    string replace -a 'setenv' 'set -x' (rbenv init -) | source
end
