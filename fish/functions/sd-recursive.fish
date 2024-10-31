function sd-recursive -a pattern replace dir -d 'Recursively search and replace text in files within a directory'
    set files (fd -H -x file -i '{}' $dir | rg text | tuc -d : -f 1)
    sd $pattern $replace $files
end
