set -Ux MTR_OPTIONS -b
set -Ux VISUAL kate
set -Ux EDITOR micro
set -Ux VOLTA_HOME ~/.volta
set -Ux PLAN9 /usr/local/plan9
set -Ux LXD_INSECURE_TLS true
set -Ux PYTORCH_CUDA_ALLOC_CONF max_split_size_mb:1024 # 设置 PyTorch 的 CUDA 内存分配策略
#set -Ux HF_HOME /data/huggingface	# 设置 HuggingFace 的缓存目录
#set -Ux BUILDKIT_PROGRESS plain
set -U UBUNTU_CODENAME (lsb_release -cs)
#set -Ux PYTHONPATH .	# 方便调试，不适合用于生产环境
#set -Ux ELECTRON_TRASH gio
set -U fish_greeting
set -U fish_features all
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
