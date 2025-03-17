#!/usr/bin/env fish

source ./include/confirm.fish

if fish_is_root_user && ! command -q sudo
    # 如果当前用户是 root 用户，且没有 sudo 命令，那么就将 sudo 命令设置为空命令
    # 虽然这样做不太安全且会报错，但不会影响后续的脚本执行
    alias -s sudo command
end

# 安装基本配置
if confirm 'Do you want to install the user-level configuration for fish?'
    source ./fish/variables/normal.fish
    if type -q tab
        tab --completion fish >~/.config/fish/completions/tab.fish
    end
    if type -q atuin
        atuin gen-completions -s fish -o ~/.config/fish/completions/
    end
    if type -q ruff
        ruff generate-shell-completion fish >~/.config/fish/completions/ruff.fish
    end
    if type -q uv
        uv generate-shell-completion fish >~/.config/fish/completions/uv.fish
    end
    if type -q uvx
        uvx --generate-shell-completion fish >~/.config/fish/completions/uvx.fish
    end
    if type -q pipx
        register-python-argcomplete --shell fish pipx >~/.config/fish/completions/pipx.fish
    end
    if type -q fnm
        fnm completions --shell fish >~/.config/fish/completions/fnm.fish
    end
    if type -q pnpm
        pnpm completion fish >~/.config/fish/completions/pnpm.fish
    end
    if type -q watchtower
        watchtower completion fish >~/.config/fish/completions/watchtower.fish
    end
    if type -q mcli
        mcli --autocompletion
    end
    if type -q supabase
        supabase completion fish >~/.config/fish/completions/supabase.fish
    end
end

if confirm 'Do you want to install the system-level configuration for fish?'
    # sudo fish -c xxx 会切换到 root 用户，并读写 root 的 fish 环境变量和用户配置
    sudo fish -c 'source ./fish/variables/normal.fish'
    sudo fish -c 'source ./fish/variables/root.fish'

    # 安装 fish 的 alias
    source ./fish/alias.fish

    # 安装 fish_plugins 文件
    cp ./pkglist/fish_plugins ~/.config/fish/

    # 设置 fish 的主题
    source /usr/share/fish/tools/web_config/sample_prompts/disco.fish
    funcsave fish_prompt
    funcsave fish_right_prompt

    # 安装系统级别的 fish 函数
    sudo mv ~/.config/fish/functions/* /etc/fish/functions/
    sudo cp ./fish/functions/* /etc/fish/functions/

    # 安装系统级别的 fish 配置
    sudo cp ./fish/conf.d/* /etc/fish/conf.d/

    # 安装系统级别的 fish 补全
    sudo mv ~/.config/fish/completions/* /etc/fish/completions/

    # 安装特殊的 fish 补全
    if type -q tabtab && type -q yarn && type -q fd
        ln -s (fd -H yarn.fish ~/.local/share/) ~/.config/fish/completions/
    end

    # 安装系统级别的 fish 脚本
    sudo install exec/* /usr/local/bin/
end

if fish_is_root_user && ! command -q sudo
    sudo mv /etc/fish/functions/sudo.fish /root/.config/fish/functions/
end
