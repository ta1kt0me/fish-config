function times -d "Exec argument command for n times"
    set count $argv[1]
    set execution $argv[2..-1]
    for x in (seq $count)
        echo $execution
        eval $execution
        if test $status -ne 0
            break
        end
    end
end
