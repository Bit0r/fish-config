proxy-aria2c -d ./ https://raw.githubusercontent.com/lobehub/lobe-chat/HEAD/docker-compose/local/setup.sh
chmod +x setup.sh
proxychains ./setup.sh -f -l zh_CN
