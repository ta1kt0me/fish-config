function git_edit -d "edit selected by peco with git ls-files"
    if test -n $argv[1]
        git ls-files $argv[1] | peco | read file
    else
        git ls-files | peco | read file
    end

    if test -n "$file"
        commandline "vim $file"
        commandline -f execute
    end
end
