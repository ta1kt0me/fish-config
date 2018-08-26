set -x PYENV_ROOT $HOME/.pyenv
set -x PATH $PYENV_ROOT/bin $PATH
string replace -a 'setenv' 'set -x' (pyenv init -) | source
