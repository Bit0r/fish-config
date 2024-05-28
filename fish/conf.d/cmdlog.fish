function cmdlog --on-event fish_postexec
    set return_val $status
    logger -t "$USER|$SSH_CONNECTION|fish|$(tty)|$fish_pid|$PWD|$return_val" -p local6.debug $argv
end
