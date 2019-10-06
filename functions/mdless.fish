function mdless -d "mdcat with less"
    set file $argv[1]
    mdcat $file | less -r
end
