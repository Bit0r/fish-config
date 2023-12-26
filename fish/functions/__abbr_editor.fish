function __abbr_editor
    if set -q VISUAL && set -q DISPLAY && ! fish_is_root_user
        echo $VISUAL $argv
    else if set -q EDITOR
        echo $EDITOR $argv
    else if command -q editor
        echo command editor $argv
    else if type -q edit
        echo edit $argv
    end
end
