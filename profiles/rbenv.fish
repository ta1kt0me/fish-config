set -x RBENV_ROOT $HOME/.rbenv
set -x PATH $RBENV_ROOT/bin $PATH
string replace -a 'setenv' 'set -x' (rbenv init -) | source
