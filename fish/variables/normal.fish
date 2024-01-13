set -Ux MANGOHUD 1
set -Ux MTR_OPTIONS -b
set -Ux EDITOR micro
set -Ux VISUAL code
set -Ux VOLTA_HOME ~/.volta
set -Ux PLAN9 /usr/local/plan9
set -Ux DOCKGE_DIR /opt/dockge # 设置 Dockge 的工作目录
set -Ux LXD_INSECURE_TLS true
set -Ux PYTORCH_CUDA_ALLOC_CONF max_split_size_mb:1024 # 设置 PyTorch 的 CUDA 内存分配策略
#set -Ux TORCH_HOME /data/torch	# 设置 PyTorch 的缓存目录
#set -Ux HF_HOME /data/huggingface	# 设置 HuggingFace 的缓存目录
set -Ux WANDB_MODE offline # 设置 wandb 的模式
#set -Ux BUILDKIT_PROGRESS plain
set -U UBUNTU_CODENAME (lsb_release -cs)
#set -Ux PYTHONPATH .	# 方便调试，不适合用于生产环境
#set -Ux ELECTRON_TRASH gio
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