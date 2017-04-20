function peco_select_repository -d "cd a repository selected by peco"
    ghq list -p | peco --query "$LBUFFER" | read repo

    if test -n "$repo"
        commandline "cd $repo"
        commandline -f execute
    end
end
