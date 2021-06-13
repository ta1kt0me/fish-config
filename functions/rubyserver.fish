function rubyserver -d "Startup webrick server"
    set -l dir "."

    if test -n "$argv[1]"
        set -l dir $argv[1]
    end

    ruby -run -e httpd $dir -p 18000
end
