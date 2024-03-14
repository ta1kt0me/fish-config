umask 022
set -x MANPATH "/usr/local/share/fish/man:"
set -g Z_SCRIPT_PATH (git config --get ghq.root)/github.com/rupa/z/z.sh
set -g PATH $HOME/.local/bin $PATH /usr/local/bin

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
alias cdroot='cd (git rev-parse --show-toplevel)'

if not test (command -s tac)
    alias tac='tail -r'
end

if not test (command -s pbcopy)
    alias pbcopy='xsel --clipboard --input'
end

if test -e ~/.asdf/asdf.fish; and not test (command -s asdf)
    source ~/.asdf/asdf.fish
end

if test (command -s flatpak)
    alias wezterm='flatpak run org.wezfurlong.wezterm'
end

if test (command -s aws)
    # https://github.com/aws/aws-cli/issues/1079#issuecomment-541997810
    complete --command aws --no-files --arguments '(begin; set --local --export COMP_SHELL fish; set --local --export COMP_LINE (commandline); aws_completer | sed \'s/ $//\'; end)'
end
