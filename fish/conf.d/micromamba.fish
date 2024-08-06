if type -q micromamba
    if fish_is_root_user
        set -gx MAMBA_ROOT_PREFIX ~/micromamba-root
    end
    micromamba shell hook -s fish | source
end
