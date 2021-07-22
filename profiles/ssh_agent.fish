function start_ssh_agent -d 'start ssh-agent'
    setenv SSH_ENV /tmp/environment

    if not test -e $SSH_ENV
        ssh-agent -c | sed 's/^echo/#echo/' > $SSH_ENV
        chmod 600 $SSH_ENV
    end

    . $SSH_ENV > /dev/null 2> /dev/null
    ssh-add > /dev/null 2> /dev/null

    if not test $status -eq '0'
        rm $SSH_ENV
        start_ssh_agent
    end
end

start_ssh_agent
