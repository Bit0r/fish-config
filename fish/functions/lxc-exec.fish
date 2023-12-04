function lxc-exec -d "Run fish shell in a container" -a container shell_path
    # container: name of the container
    # shell_path: path to the shell to run
    if [ ! $shell_path ]
        set shell_path /usr/bin/fish
    end
    lxc exec $container -- sudo -iu ubuntu $shell_path
end
