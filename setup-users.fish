#!/usr/bin/env fish
for user in (lsusers)
    sudo -u $user ./configs-fish.fish
    sudo -u $user ./configs-user.fish
    # sudo -u $user ./third-party.fish
    # sudo -u $user ./slow.fish
end
