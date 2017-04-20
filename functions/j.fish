function j -d "Jump selected directory"
    z | tail -r | awk '{print $2}' | peco | read directory

    if test -n "$directory"
        commandline "cd $directory"
        commandline -f execute
    end
end
