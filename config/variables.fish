set -Ux MTR_OPTIONS -b
set -Ux VISUAL kate
set -Ux EDITOR micro
set -Ux VOLTA_HOME ~/.volta
set -Ux PLAN9 /usr/local/plan9
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
