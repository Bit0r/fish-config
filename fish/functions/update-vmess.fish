function update-vmess -d 'Update vmess subscription file' -a url
    aria2c -o sub.txt $url
    cat sub.txt | vmess2json --parse_all --outbound
    for file in *.json
        mv $file (path change-extension _tail.json $file)
    end
end
