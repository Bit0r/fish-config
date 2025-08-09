#!/usr/bin/env fish
for user in (lsusers)
    sudo -u $user ./config-fish.fish
    sudo -u $user ./config-user.fish
    # sudo -u $user ./install-third-party.fish
    # sudo -u $user ./install-slow.fish
end
