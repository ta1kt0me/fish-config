function fzf_select_history -d "select history by fzf"
    history | fzf | read cmd

    if test -n "$cmd"
        commandline "$cmd"
    end
end
