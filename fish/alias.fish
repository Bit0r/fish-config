set -l http_proxy http://localhost:8800
set -l socks5_proxy socks5://localhost:1080
set -l socks5h_proxy socks5h://localhost:1080

alias -s http_proxy "ALL_PROXY=$http_proxy HTTP_PROXY=$http_proxy HTTPS_PROXY=$http_proxy"
alias -s socks5_proxy "ALL_PROXY=$socks5_proxy HTTP_PROXY=$socks5_proxy HTTPS_PROXY=$socks5_proxy"
alias -s socks5h_proxy "ALL_PROXY=$socks5_proxy HTTP_PROXY=$socks5h_proxy HTTPS_PROXY=$socks5h_proxy"

alias -s lnav-xray 'lnav /var/log/xray/*.log'
alias -s proxy-wget2 "wget2 --http-proxy=$http_proxy"
alias -s proxy-wget "HTTP_PROXY=$http_proxy HTTPS_PROXY=$http_proxy wget"
alias -s proxy-go "HTTP_PROXY=$http_proxy HTTPS_PROXY=$http_proxy go"
alias -s proxy-curl "curl -x $socks5h_proxy"
alias -s proxy-apt "apt -o Acquire::http::Proxy=$socks5h_proxy"
alias -s proxy-pip "pip --proxy $socks5h_proxy"
alias -s proxy-aria2c "aria2c --all-proxy=$http_proxy"
alias -s proxy-git-lfs "git -c http.proxy=$http_proxy lfs"
alias -s gh "HTTP_PROXY=$http_proxy HTTPS_PROXY=$http_proxy command gh"
alias -s ssh-proxy 'ssh -R 1080:localhost:1080 -R 8800:localhost:8800'

alias -s pipx-global 'PIPX_HOME=/usr/local/lib/pipx PIPX_BIN_DIR=/usr/local/bin pipx'
alias -s gdb 'gdb -quiet'
if type -q exa
    alias -s ls 'exa -xF --group-directories-first'
    alias -s ll 'ls -lhg@'
    alias -s la 'll -a'
end
alias -s logout 'loginctl terminate-user'
alias -s unar 'unar -k skip'
alias -s readelf 'readelf -W'
alias -s cnki2bib 'cnki2bib -nod'
alias -s nvrun 'env DRI_PRIME=1 __NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia __VK_LAYER_NV_optimus=NVIDIA_only VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/nvidia_icd.x86_64.json'
alias -s rsync-safe 'rsync --ignore-existing'

alias -s man-vivaldi "man -H'vivaldi --no-sandbox'"
alias -s residual-config "dpkg -l | rg '^rc' | tuc -e '\s+' -f 2"

set -e http_proxy
set -e socks5_proxy
set -e socks5h_proxy
