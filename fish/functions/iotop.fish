function iotop --description 'Show I/O usage per process' --wraps iotop
    # task_delayacct has performance impact, so we only enable it for the duration of the iotop run
    sudo sysctl kernel.task_delayacct=1
    sudo iotop $argv
    if ! pgrep -x iotop
        # all iotop processes have exited, so we can disable task_delayacct
        sudo sysctl kernel.task_delayacct=0
    end
end
