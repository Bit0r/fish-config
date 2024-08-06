set -l users \
    dai_haohua \
    hu_kaiyu \
    pan_yh \
    wu_zhiming \
    xu_yuting \
    zhang_jun \
    zhao_siliang \
    zhou_min \
    liu_qipeng
for user in $users
    sudo -u $user ./configs-fish.fish
    sudo -u $user ./configs-user.fish
    # sudo -u $user ./third-party.fish
    # sudo -u $user ./slow.fish
end
