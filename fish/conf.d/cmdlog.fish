function record_runtime --on-event fish_postexec
    logger -t "[$USER] [$SSH_CONNECTION] [fish] [$fish_pid] [$PWD] [$status]" -p local6.debug $argv
end
