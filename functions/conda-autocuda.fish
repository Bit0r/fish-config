function conda-autocuda -d "Set CUDA_HOME to the given path when activating this environment" -a cuda_home
    mkdir -p $CONDA_PREFIX/etc/conda/activate.d/
    echo cuda-home $cuda_home >$CONDA_PREFIX/etc/conda/activate.d/autocuda.fish
end
