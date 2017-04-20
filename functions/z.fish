function z -d "Directory list"
    bash -c "source $Z_SCRIPT_PATH; _z $argv 2>&1"
end

function z.check --on-variable PWD --description 'Add changed directory into z'
    status --is-command-substitution; and return
    bash -c "source $Z_SCRIPT_PATH; _z --add `pwd -P`"
end
