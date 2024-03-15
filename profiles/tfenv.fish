if test -z "$TFENV_ROOT"
    set -x TFENV_ROOT $HOME/.tfenv
    fish_add_path -g $TFENV_ROOT/bin
end
