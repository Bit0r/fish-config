function editor --description 'Open a file in the editor of your choice' --wraps editor
    if set -q VISUAL && set -q DISPLAY && ! fish_is_root_user
        $VISUAL $argv
    else if set -q EDITOR
        $EDITOR $argv
    else if command -q editor
        command editor $argv
    else if type -q edit
        edit $argv
    end
end
