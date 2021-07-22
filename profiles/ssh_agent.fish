function start_ssh_agent -d 'start ssh-agent'
    setenv SSH_ENV /tmp/environment

    if not test -e $SSH_ENV
        echo "[start_ssh_agent] start up ssh-agent"
        killall ssh-agent
        ssh-agent -c | sed 's/^echo/#echo/' > $SSH_ENV
        chmod 600 $SSH_ENV
    end

    . $SSH_ENV > /dev/null 2> /dev/null
    ssh-add > /dev/null 2> /dev/null

    if not test $status -eq '0'
        rm $SSH_ENV
        echo "[start_ssh_agent] restart ssh-agent"
        start_ssh_agent
    end
end

start_ssh_agent
