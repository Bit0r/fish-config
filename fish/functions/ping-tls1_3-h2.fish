function ping-tls1_3-h2 -a domain -d "Ping a domain with TLS 1.3, HTTP/2"
    openssl s_client -alpn h2 -tls1_3 -cipher ECDHE-ECDSA-AES256-GCM-SHA384 -status -connect $domain:443
end
