function purge-configs --description 'Purge all config files for uninstalled packages'
    sudo apt purge (dpkg -l | rg '^rc' | tuc -e '\s+' -f 2)
end
