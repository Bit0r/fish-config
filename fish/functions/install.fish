function install -d "Install SOURCE files to DIRECTORY"
    if [ -z "$argv" ]
        echo "Usage: install SOURCE... DIRECTORY"
        false
        return
    else if [ (count $argv) -lt 2 ]
        set target_dir /usr/local/bin/
    else
        set target_dir $argv[-1]
        set -e argv[-1]
    end

    sudo install -D $argv -t $target_dir
end
