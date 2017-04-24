function replace_git_grep -d "Replace string by git grep"
    set target $argv[1]
    set replace $argv[2]
    git grep -l $target | xargs sed -i '' -e "s/$target/$replace/g"
end
