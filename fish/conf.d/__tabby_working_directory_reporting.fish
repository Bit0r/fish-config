function __tabby_working_directory_reporting -e fish_prompt -d 'Report working directory to tabby'
    echo -en "\e]1337;CurrentDir=$PWD\x7"
end
