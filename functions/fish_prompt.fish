function _git_status
    if test -d '.git'
        if test (git diff --staged --name-only | wc -l | tr -d ' ') != 0
            echo -n -s (set_color green) '+'
        end
        if test (git diff --name-only | wc -l | tr -d ' ') != 0
            echo -n -s (set_color yellow) '+'
        end
        if test (git ls-files --other --exclude-standard | wc -l | tr -d ' ') != 0
            echo -n -s (set_color red) '+'
        end
    else
        echo -n ''
    end
end

function _current_git_branch
    if test -d '.git'
        set -l normal_color (set_color normal)
        set -l branch_name (git symbolic-ref --short HEAD; or git show-ref --head -s --abbrev | head -n1)
        echo -n -s $normal_color ':' $branch_name (_git_status) $normal_color ''
    else
        echo -n ''
    end
end

function _current_path
    set -l dir_color (set_color yellow)
    echo -n -s $dir_color (prompt_pwd)
end

function fish_prompt
    set -l normal_color (set_color normal)
    set -l blue_color (set_color cyan)

    echo -n -s $blue_color '(' (id -gn) ')'
    echo -n -s $normal_color (date "+%H:%M:%S")
    echo -n -s ' ' (_current_path) (_current_git_branch)

    if test (command -s rbenv)
        echo -n -s ' ' $normal_color 'ruby:' (rbenv version-name)
    end

    if test (command -s node)
        echo -n -s ' ' $normal_color 'node:' (node --version)
    end

    echo ''
    echo '(Φ ω Φ> '
end
