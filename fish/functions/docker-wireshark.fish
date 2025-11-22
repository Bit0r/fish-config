function docker-wireshark -a container -a interface
    if [ -z "$interface" ]
        set interface eth0
    end

    docker run \
        --rm \
        --net=container:$container \
        nicolaka/netshoot \
        tcpdump \
        -i $interface \
        -w - \
        | wireshark -k -i -
end
