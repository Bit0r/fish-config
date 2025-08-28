#!/usr/bin/fish
source include/confirm.fish

# 添加来自 OBS (Open Build Service) 的 Zypper 软件源
if confirm 'Do you want to add some OBS?'
    for repo in (cat ./config/zypper/repos.txt | grep -v '^#')
        sudo zypper addrepo -p 200 $repo
    end
end

# 给某些软件源使用代理
if confirm 'Do you want to set a proxy for the repository?'
    set proxy_url http://localhost:8800
    for repo in vivaldi home_Psheng home_MasterPatricko
        zypper-set-proxy $repo $proxy_url
    end
end
