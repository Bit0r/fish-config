function nginx-sitectl
    set prefix /etc/nginx
    set file $argv[2]

    switch $argv[1]
        case enable
            sudo ln -s $prefix/sites-available/$file $prefix/sites-enabled/$file
        case disable
            sudo rm $prefix/sites-enabled/$file
        case '*'
            echo 'The subcommands are "enable" or "disable".'
    end
end
