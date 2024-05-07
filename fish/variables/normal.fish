set -Ux MTR_OPTIONS -b
set -Ux EDITOR micro
set -Ux VISUAL code
set -Ux BROWSER vivaldi
set -Ux BROWSER_PATH /usr/bin/$BROWSER
set -Ux CHROME_PATH $BROWSER_PATH
set -Ux CHROMIUM_PATH $CHROME_PATH
set -Ux PUPPETEER_EXECUTABLE_PATH $CHROMIUM_PATH
set -Ux VOLTA_HOME ~/.volta
set -Ux rime_frontend fcitx5-rime
#set -Ux rime_dir ~/.local/share/fcitx5/rime
set -Ux PLAN9 /usr/local/plan9
set -Ux CRON_DB_PATH ~/.config/crontab-ui
set -Ux DOCKER_COMPOSE_DIR /srv/docker/compose # 设置 Docker Compose 的工作目录
set -Ux DOCKER_DATA_DIR /var/lib/docker # 设置 Docker 的数据目录
set -Ux LXD_INSECURE_TLS true
set -Ux PYTORCH_CUDA_ALLOC_CONF max_split_size_mb:1024 # 设置 PyTorch 的 CUDA 内存分配策略
#set -Ux TORCH_HOME /data/torch# 设置 PyTorch 的缓存目录
set -Ux MAMBA_ROOT_PREFIX ~/micromamba # 设置 Micromamba 的根目录
#set -Ux HF_HOME /data/huggingface # 设置 HuggingFace 的缓存目录
#set -Ux LLAMA_INDEX_CACHE_DIR /data/llama-index # 设置 LLAMA 的缓存目录
#set -Ux DEEPLAKE_DOWNLOAD_PATH /data/deeplake # 设置 DeepLake 的下载目录
set -Ux WANDB_MODE offline # 设置 wandb 的模式
#read -sUx OPENAI_API_KEY # 设置 OpenAI 的 API 密钥
set -Ux OPENAI_API_BASE https://api.chatkore.com/v1 # 设置 OpenAI 的 API 地址
set -Ux OPENAI_BASE_URL $OPENAI_API_BASE
set -Ux OPENAI_LOG debug # 设置 OpenAI 的日志级别
#set -Ux BUILDKIT_PROGRESS plain
set -U UBUNTU_CODENAME (lsb_release -cs)
set -U UBUNTU_NUMBER (lsb_release -rs)
#set -Ux PYTHONPATH . # 方便调试，不适合用于生产环境
set -Ux ELECTRON_TRASH kioclient5
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
    $VOLTA_HOME/bin \
    ~/.local/share/fnm \
    ~/.yarn/bin \
    ~/.config/composer/vendor/bin
