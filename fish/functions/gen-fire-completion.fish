function gen-fire-completion -a command_name is_system -d "Generate completion for Fire command"
    # 先测试command_name是否已经是完整路径
    if [ -f $command_name ]
        set command_path $command_name
        # 如果是完整路径，那么就取basename
        set command_name (path basename $command_name)
    else
        # 如果不是完整路径，那么就在PATH中查找
        set command_path (type -P $command_name)
    end

    if [ -z $is_system ]
        # 默认安装到用户目录
        python $command_path -- --completion fish >~/.config/fish/completions/$command_name.fish
    else
        # 如果开启is_system选项，那么就安装到系统目录
        python $command_path -- --completion fish | sudo tee /etc/fish/completions/$command_name.fish >/dev/null
    end
end
