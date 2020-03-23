function pecol -d "select a command then eavl"
    set -l lines

    while read -la line
        set -a lines "$line\n"
    end

    echo -e $lines | string trim --left --chars=" " | grep -E -v '^$' | peco | read cmd

    if test -n "$cmd"
        commandline "$cmd"
        commandline -f execute
    end
end
