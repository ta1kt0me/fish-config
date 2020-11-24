umask 022
set -x MANPATH "/usr/local/share/fish/man:"
set -g Z_SCRIPT_PATH (git config --get ghq.root)/github.com/rupa/z/z.sh
set -g PATH $HOME/.local/bin $PATH

set fish_greeting

begin
    set -l source_dirs hooks abbrs profiles
    set -l fish_config_dir "$HOME/.config/fish"

    pushd $fish_config_dir

    for dir in $source_dirs
        if test -d $dir; and not test (git check-ignore $dir)
            for src in (ls $dir)
                if not test (git check-ignore $dir/$src)
                    source $dir/$src
                end
            end
        end
    end

    if test -e $fish_config_dir/local.fish
        source $fish_config_dir/local.fish
    end

    popd
end

alias pcp='peco | tr -d "\n" | pbcopy'
alias gosh='rlwrap gosh'
alias ge='git_edit'
alias rw='reg_word'
alias awswhoami='aws sts get-caller-identity'
alias ldenv='load_dotenv'

if not test (command -s tac)
    alias tac='tail -r'
end

if not test (command -s pbcopy)
    alias pbcopy='xsel --clipboard --input'
end
