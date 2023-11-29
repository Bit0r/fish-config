function cat --wraps=bat --description 'alias cat bat'
    if type -q bat
        bat $argv
    else if type -q batcat
        batcat $argv
    else
        command cat $argv
    end
end
