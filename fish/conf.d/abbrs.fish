set -l http_proxy http://localhost:8800
set -l socks5_proxy socks5://localhost:1080
set -l socks5h_proxy socks5h://localhost:1080

abbr -a --position anywhere proxy-wget2 "wget2 --http-proxy=$http_proxy"
abbr -a --position anywhere proxy-wget "http_proxy=$http_proxy https_proxy=$http_proxy wget"
abbr -a --position anywhere proxy-curl "curl -x $socks5h_proxy"
abbr -a --position anywhere proxy-aria2c "aria2c --all-proxy=$http_proxy"
abbr -a --position anywhere proxy-apt apt -o Acquire::http::Proxy=$socks5h_proxy
abbr -a --position anywhere proxy-pip pip --proxy $socks5h_proxy

#abbr -a __editor -r '.+(\.txt|rc|env)' -f __abbr_editor

set -e http_proxy
set -e socks5_proxy
set -e socks5h_proxy
