function cuda-home -d "Set CUDA_HOME to the given path" -a path
    # 清除环境变量
    set -ge LD_LIBRARY_PATH
    set -ge fish_user_paths
    # 设置环境变量
    set -gx CUDA_HOME (path normalize $path)
    set --path -gxp LD_LIBRARY_PATH $CUDA_HOME/lib64
    fish_add_path -g $CUDA_HOME/bin
end
