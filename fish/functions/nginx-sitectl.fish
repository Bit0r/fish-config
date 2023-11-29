function nginx-sitectl -d "Enable or disable a site in nginx" -a subcommand file
    set prefix /etc/nginx

    switch $subcommand
        case enable
            sudo ln -s $prefix/sites-available/$file $prefix/sites-enabled/$file
        case disable
            sudo rm $prefix/sites-enabled/$file
        case '*'
            echo 'The subcommands are "enable" or "disable".'
    end
end
