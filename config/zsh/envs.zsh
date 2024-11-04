# XDG 桌面目录规范
export XDG_CONFIG_HOME=${HOME}/.config # 程序配置文件
export XDG_CACHE_HOME=$HOME/.cache # 程序缓存文件
export XDG_DATA_HOME=$HOME/.local/share # 程序数据文件
export XDG_STATE_HOME=$HOME/.local/state # 程序状态文件

# 默认程序
export EDITOR=nvim  # 默认编辑器
export VISUAL=nvim  # 默认编辑器
export BROWSER=wyeb # 默认浏览器

# conda
export CONDA_ENVS_DIRS=${XDG_DATA_HOME}/conda/envs # conda-zsh-completion 虚拟环境目录
export TERMINFO=/usr/share/terminfo # 解决 conda环境下 clear 报错

# zsh
export HISTFILE=${XDG_STATE_HOME}/zsh/zsh_history # zsh 历史命令记录
export _ZL_DATA=${XDG_STATE_HOME}/zsh/zlua # zlua 数据文件
export OMZ=${XDG_DATA_HOME}/ohmyzsh # oh-my-zsh 目录

# go
export GOPATH=${XDG_DATA_HOME}/go # go get 下载的包的位置
export GOBIN=${GOPATH}/bin # go install 安装的可执行文件的位置

# java
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java

# gnupg 凭证
export GNUPGHOME=${XDG_DATA_HOME}/gnupg

# rust
export CARGO_HOME=${XDG_DATA_HOME}/cargo

# gradle
export GRADLE_USER_HOME=${XDG_DATA_HOME}/gradle

# npm
export NPM_CONFIG_USERCONFIG=${XDG_CONFIG_HOME}/npm/npm.conf

# cuda
export CUDA_CACHE_PATH=${XDG_CACHE_HOME}/nv

# python
export PYTHONPYCACHEPREFIX=$XDG_CACHE_HOME/python
export PYTHONSTARTUP=$XDG_CONFIG_HOME/python/startup.py # python 启动时运行的文件
export PYTHONHISTFILE=$XDG_STATE_HOME/python/history # python 历史命令记录
export IPYTHONDIR=$XDG_STATE_HOME/python/ipython # ipython 目录

# tensorflow
export KERAS_HOME=${XDG_CACHE_HOME}/keras

# mysql
export MYSQL_HISTFILE=${XDG_DATA_HOME}/mysql/mysql_history

# wget
export WGETRC=${XDG_CONFIG_HOME}/wget/wgetrc

# qt
# export QT_DEBUG_PLUGINS=1 # qt debug模式，显示更多报错信息

# PATH
_ruby="$XDG_DATA_HOME/gem/ruby/3.0.0/bin"  # 加上 ruby 环境
_local_bin="$HOME/.local/bin"
_cuda_bin="/usr/local/cuda/bin"
export PATH="$GOBIN:$_ruby:$_local_bin:$_cuda_bin:$PATH"
unset _ruby _local_bin _cuda_bin

# LD_LIBRARY_PATH
_cuda_lib="/usr/local/cuda/lib64"
export LD_LIBRARY_PATH=$_cuda_lib:${LD_LIBRARY_PATH}
unset _cuda_lib

# huggingface
export HF_ENDPOINT=https://hf-mirror.com # huggingface 镜像
