if status is-interactive
    if type -q zoxide
        zoxide init fish | source
    end
    # if type -q atuin
    #     atuin init fish | source
    # end
end

if type -q fnm
    fnm env | source
end
