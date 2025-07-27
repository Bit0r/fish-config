set -l http_proxy http://localhost:8800
set -l socks5_proxy socks5://localhost:1080
set -l socks5h_proxy socks5h://localhost:1080

alias -s http_proxy "ALL_PROXY=$http_proxy HTTP_PROXY=$http_proxy HTTPS_PROXY=$http_proxy"
alias -s socks5_proxy "ALL_PROXY=$socks5_proxy HTTP_PROXY=$socks5_proxy HTTPS_PROXY=$socks5_proxy"
alias -s socks5h_proxy "ALL_PROXY=$socks5h_proxy HTTP_PROXY=$socks5h_proxy HTTPS_PROXY=$socks5h_proxy"

alias -s lnav-xray 'lnav /var/log/xray/*.log'

alias -s proxy-sudo "sudo ALL_PROXY=$http_proxy HTTP_PROXY=$http_proxy HTTPS_PROXY=$http_proxy"
alias -s proxy-go "HTTP_PROXY=$http_proxy HTTPS_PROXY=$http_proxy go"
alias -s proxy-git-lfs "git -c http.proxy=$http_proxy lfs"
alias -s proxy-curl "curl -x $socks5h_proxy"
alias -s proxy-aria2c "aria2c --all-proxy=$http_proxy"
alias -s gh "HTTP_PROXY=$http_proxy HTTPS_PROXY=$http_proxy command gh"
alias -s shadcn-vue 'proxychains shadcn-vue'
alias -s ssh-proxy 'ssh -R 1080:localhost:1080 -R 8800:localhost:8800 -N'
alias -s ssh-google 'ssh -L 53682:localhost:53682 -N'

alias -s gdb 'gdb -quiet'
if type -q eza
    alias -s ls 'eza -xF --group-directories-first'
    alias -s ll 'ls -lhg@'
    alias -s la 'll -a'
end
alias -s lsusers "members -s users | string split ' '"
alias -s logout 'loginctl terminate-user'
alias -s unar 'unar -k skip'
alias -s readelf 'readelf -W'
alias -s cnki2bib 'cnki2bib -nod'
alias -s nvrun 'env DRI_PRIME=1 __NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia __VK_LAYER_NV_optimus=NVIDIA_only VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/nvidia_icd.x86_64.json'
alias -s rsync-safe 'rsync --ignore-existing'

alias -s purge-configs 'sudo aptitude purge ~c'

alias -s man-vivaldi "man -H'vivaldi --no-sandbox'"
alias -s man-browser 'man -H"$BROWSER --no-sandbox"'
alias -s residual-config "dpkg -l | rg '^rc' | tuc -e '\s+' -f 2"
alias -s renamer-vscode "renamer -e 'code -w'"

alias -s scc-china 'scc -a -d --no-min-gen --avg-wage 120000 --eaf 0.8 --overhead 0.25 --cocomo-project-type custom,0.5,1.1,1.2,0.5 --sloccount-format --currency-symbol ¥'

set -e http_proxy
set -e socks5_proxy
set -e socks5h_proxy
