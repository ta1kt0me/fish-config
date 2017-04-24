function peco_checkout_remote_branch -d "check out remote branch by peco"
    git branch -r | sed -e "s/\-> .*//g" | peco | read branch

    if test -n "$branch"
        set local_branch (ruby -e "print ARGV.first.match(/.*?\/(.*)/)[1]" $branch)
        commandline "git checkout -b $local_branch $branch"
        commandline -f execute
    end
end
