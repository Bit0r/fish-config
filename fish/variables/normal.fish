#set -Ux UID (id -u) # 设置当前用户的 UID
set -Ux VERSION_CONTROL numbered # 设置cp、mv等命令的备份方式，避免覆盖
set -Ux MTR_OPTIONS -b
set -Ux PAGER ov
set -Ux MANPAGER "ov --section-delimiter '^[^\s]' --section-header"
#set -Ux SUDO_EDITOR msedit
set -Ux EDITOR msedit
set -Ux VISUAL code
set -Ux BROWSER vivaldi
set -Ux BROWSER_PATH /usr/bin/$BROWSER
set -Ux CHROME_PATH $BROWSER_PATH
set -Ux CHROMIUM_PATH $CHROME_PATH
set -Ux PUPPETEER_EXECUTABLE_PATH $CHROMIUM_PATH
set -Ux DENO_INSTALL ~/.deno
set -Ux VOLTA_HOME ~/.volta
set -Ux rime_frontend fcitx5-rime
#set -Ux rime_dir ~/.local/share/fcitx5/rime
set -Ux PLAN9 /usr/local/plan9
set -Ux CRON_DB_PATH ~/.config/crontab-ui
set -Ux DOCKER_COMPOSE_DIR /srv/docker/compose # 设置 Docker Compose 的工作目录
set -Ux DOCKER_DATA_DIR /var/lib/docker # 设置 Docker 的数据目录
set -Ux YAMLFIX_CONFIG_PATH /etc/yamlfix/ # 设置 yamlfix 的配置文件路径
set -Ux LXD_INSECURE_TLS true
set -Ux NODE_OPTIONS '--max-old-space-size=20480' # 设置 Node.js 的内存限制
set -Ux PYTORCH_CUDA_ALLOC_CONF max_split_size_mb:1024,expandable_segments:True # 设置 PyTorch 的 CUDA 内存分配策略
#set -Ux TORCH_HOME /data/torch# 设置 PyTorch 的缓存目录
#set -Ux MAMBA_ROOT_PREFIX ~/micromamba # 设置 Micromamba 的根目录
#set -Ux HF_HOME /data/huggingface # 设置 HuggingFace 的缓存目录
#set -Ux LLAMA_INDEX_CACHE_DIR /data/llama-index # 设置 LLAMA 的缓存目录
#set -Ux DEEPLAKE_DOWNLOAD_PATH /data/deeplake # 设置 DeepLake 的下载目录
set -Ux WANDB_MODE offline # 设置 wandb 的模式
#read -sUx WANDB_API_KEY # 设置 wandb 的 API 密钥
#set -Ux GRADIO_SERVER_PORT 6006 # 设置 Gradio 的服务器端口
#read -sUx OPENAI_API_KEY # 设置 OpenAI 的 API 密钥
set -Ux OPENAI_BASE_URL https://api.openai.com/v1 # 设置 OpenAI 的基础 URL
set -Ux OPENAI_API_BASE $OPENAI_BASE_URL
set -Ux OPENAI_PROXY_URL $OPENAI_API_BASE
set -Ux OPENAI_LOG debug # 设置 OpenAI 的日志级别
#read -sUx DASHSCOPE_API_KEY # 设置 Dashscope 的 API 密钥
set -Ux BUILDKIT_PROGRESS plain # 设置 BuildKit 的进度条样式，一定要设置为 plain，否则容器内的日志无法正常显示
#set -Ux PYTHONPATH . # 方便调试，不适合用于生产环境
set -Ux ELECTRON_TRASH kioclient5
#set -Ux COLORTERM truecolor # 设置终端的颜色支持
if [ "$COLORTERM" = truecolor ]
    set -Ux MICRO_TRUECOLOR 1 # 设置 micro 的 truecolor 支持
end
set -U fish_greeting
set -U fish_features all
set -U dirprev
set -U dirnext
set -U fish_user_paths \
    ~/.local/bin \
    ~/go/bin \
    /usr/local/cuda/bin \
    /usr/local/go/bin \
    ~/.cargo/bin \
    $DENO_INSTALL/bin \
    $VOLTA_HOME/bin \
    ~/.local/share/fnm \
    ~/.yarn/bin \
    ~/.config/composer/vendor/bin \
    ~/.local/share/JetBrains/Toolbox/bin \
    ~/.local/share/JetBrains/Toolbox/scripts
