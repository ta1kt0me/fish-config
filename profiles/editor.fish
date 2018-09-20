if test (uname) = Linux
    set -x GIT_EDITOR '/usr/bin/vim'
else
    set -x GIT_EDITOR '/usr/local/bin/vim'
end
set -x EDITOR 'vim'
