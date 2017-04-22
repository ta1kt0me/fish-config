function peco_checkout_branch -d "check out selected branch by peco"
    git branch | peco | sed -e "s/\* //g" | read branch

    if test -n "$branch"
        commandline "git checkout $branch"
        commandline -f execute
    end
end
