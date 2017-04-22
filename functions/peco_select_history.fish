function peco_select_history -d "select history by peco"
    history | peco | read cmd

    if test -n "$cmd"
        commandline "$cmd"
    end
end
