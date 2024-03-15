if test -z "$PYENV_ROOT"
  set -gx PYENV_ROOT $HOME/.pyenv
  fish_add_path $PYENV_ROOT/bin
  status is-login; and pyenv init --path | source
  status is-interactive; and pyenv init - | source
end
