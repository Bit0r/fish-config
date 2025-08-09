function zypper-set-proxy -a alias -a action -d 'Sets or removes a proxy for an EXISTING zypper repository.'
    # Usage: zypper-set-proxy <alias> [proxy_url]
    # Example (Set Proxy):   zypper-set-proxy my-repo http://proxy.server:port
    # Example (Remove Proxy): zypper-set-proxy my-repo

    set repo_path /etc/zypp/repos.d/$alias.repo

    # 先删除代理
    sudo sd '\??proxy=.*' '' $repo_path

    if [ -z "$action" ]
        # 如果没有提供 action 参数，则只删除代理
        return
    end

    # 再根据参数添加代理
    sudo fish -c "echo proxy=$action >>$repo_path"
end
