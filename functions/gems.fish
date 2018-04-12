function gems -d "Show bundler gem list"
    bundle check > /dev/null

    if test $status -eq 0
        bundle exec ruby -e "require 'bundler'; puts Bundler.load.specs.sort_by(&:name).map(&:name)" | peco | xargs bundle show | read gem
    else
        echo "Execute `gems` in dirs using bundle"
        exit 1
    end

    if test -n "$gem"
        commandline "vim $gem"
        commandline -f execute
    end
end
