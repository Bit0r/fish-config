# 定义确认函数
function confirm -d "Confirm a command" -a prompt
    read -P "$prompt [y/N] " REPLY
    [ $REPLY = y ]
end
