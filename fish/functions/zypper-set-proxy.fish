function zypper-set-proxy -a alias -a action -d 'Sets or removes a proxy for an EXISTING zypper repository.'
    # 使用 'count' 命令检查参数数量，这是更标准的 Fish 写法
    if [ (count $argv) != 2 ]
        echo 'Usage: zypper-set-proxy <alias> <proxy_url | remove>
Example (Set Proxy):   zypper-set-proxy my-repo http://proxy.server:port
Example (Remove Proxy): zypper-set-proxy my-repo remove'
        return 1
    end

    set repo_path /etc/zypp/repos.d/$alias.repo

    # 先删除代理
    sudo sd '\??proxy=.*' '' $repo_path
    if [ "$action" != remove ]
        # 再根据参数添加代理
        sudo fish -c "echo proxy=$action >>$repo_path"
    end
end
