function notify_postexec --on-event fish_postexec
    if test (command -s terminal-notifier)
        set -l cmd_res $status
        string match -r '^bundle$|bundle install| be |bundle exec|bin' $argv | read match
        string length -q $match
        if [ $status = 0 ]
            if [ $cmd_res = 0 ]
                set -x res "🍏🍏🍏"
            else
                set -x res "🍎🍎🍎"
            end

            terminal-notifier -title "😎$argv" -message "$res Complete" -sound Submarine -timeout 10 -activate "com.googlecode.iterm2" > /dev/null &
            set -e res
        end
    end
end
