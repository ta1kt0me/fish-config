set -x MANPATH "/usr/local/share/fish/man:"
set -g Z_SCRIPT_PATH /usr/local/opt/z/etc/profile.d/z.sh

begin
    set -l source_dirs hooks abbrs
    set -l fish_config_dir "$HOME/.config/fish"

    pushd $fish_config_dir

    for dir in $source_dirs
        if test -d $dir; and not test (git check-ignore $dir)
            for src in (ls $dir)
                if not test (git check-ignore $dir/$src)
                    source $dir/$src
                end
            end
        end
    end

    popd
end
