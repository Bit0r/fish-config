#!/usr/bin/env fish

for user in (lsusers)
    set -l uid (id -u $user)
    # echo $user\tssh:2$uid\tvnc:5$uid
    # sudo -u $user UID=$uid docker compose config
    sudo -u $user UID=$uid docker compose up -d --force-recreate
end
