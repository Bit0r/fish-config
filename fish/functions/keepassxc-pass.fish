function keepassxc-pass -a dbname entry -d 'Show password for entry in KeePassXC database.'
    # $dbname - the path without the .kdbx file extension.
    # $entry - the name of the entry in the database.
    keepassxc-cli show -sa password --no-password -qk $dbname.keyx $dbname.kdbx $entry
end
