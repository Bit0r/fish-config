for user in dai_haohua hu_kaiyu pan_yh wu_zhiming xu_yuting zhang_jun zhao_siliang zhou_min liu_qipeng
    set -l uid (id -u $user)
    # echo $user\tssh:2$uid\tvnc:5$uid
    # sudo -u $user UID=$uid docker compose config
    sudo -u $user UID=$uid docker compose up -d
end
