function sd-recursive -a pattern replace dir -d 'Recursively search and replace text in files within a directory'
    set files (fd -H $dir -x file -i {} | rg text/ | tuc -d : -f 1)
    for file in $files
        sd $pattern $replace $file
    end
end
