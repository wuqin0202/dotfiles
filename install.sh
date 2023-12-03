#! /bin/bash
source $(pwd)/config/zsh/envs.zsh

# 创建 ZDOTDIR 变量
if [ -z $ZDOTDIR ]; then
    echo "写入 ZDOTDIR 环境变量···"
    echo "export ZDOTDIR=$HOME/.config/zsh" | sudo tee -a /etc/zsh/zshenv > /dev/null
fi

# 创建各环境变量的目录
mkdir -p ${XDG_CONFIG_HOME} ${XDG_CACHE_HOME} ${XDG_DATA_HOME} ${XDG_STATE_HOME} # 创建 XDG 目录
mkdir -p ${CONDA_ENVS_DIRS} # conda 有关目录
mkdir -p ${HISTFILE%/*} ${_ZL_DATA%/*} # zsh 有关目录
mkdir -p ${XDG_DATA_HOME}/npm ${XDG_CACHE_HOME}/npm # npm 有关目录
mkdir -p ${GOPATH} ${GOBIN} ${_JAVA_OPTIONS#*=} ${GNUPGHOME} ${CARGO_HOME} # 其他程序
if [ ! -e "$XDG_STATE_HOME/python/history" ]; then
    echo "创建 python 历史记录文件···"
    mkdir -p $XDG_STATE_HOME/python
    touch $XDG_STATE_HOME/python/history
fi

if [ -n $(uname -r | grep -i "wsl") ]; then
    is_wsl="yes"
else
    is_wsl="no"
fi

echo "是否覆盖原来的配置文件？（yes/no）"
read is_overwrite
if [ $is_overwrite = "yes" ]; then
    echo "覆盖原来的配置文件···"
    rm -rf $ZDOTDIR
    rm -rf $XDG_CONFIG_HOME/conda
    rm -rf $XDG_CONFIG_HOME/pip
    rm -rf $XDG_CONFIG_HOME/wget
    rm -rf $XDG_CONFIG_HOME/npm
    rm -rf $XDG_CONFIG_HOME/python
    rm -rf $XDG_CONFIG_HOME/nvim
    rm -rf $XDG_CONFIG_HOME/git
    rm -rf $OMZ
    if [ ! $is_wsl = "yes" ]; then
        rm -rf $XDG_CONFIG_HOME/hypr
        rm -rf $XDG_CONFIG_HOME/waybar
    fi
fi

# docker
if command -v docker > /dev/null 2>&1; then
    if [ $is_overwrite = "yes" ]; then
        echo "删除原来的 docker 配置文件···"
        sudo rm -rf /etc/docker
    fi
    echo "写入 docker 配置文件···"
    sudo mkdir -p /etc/docker
    sudo ln -s $(pwd)/config/docker/daemon.json /etc/docker/daemon.json
fi


# 创建软链接
[ -e $ZDOTDIR ] || (echo "创建 zsh 软链接···" && ln -s $(pwd)/config/zsh $ZDOTDIR)
[ -e "$XDG_CONFIG_HOME/conda" ] || (echo "创建 conda 软链接···" && ln -s $(pwd)/config/conda $XDG_CONFIG_HOME/conda)
[ -e "$XDG_CONFIG_HOME/pip" ] || (echo "创建 pip 软链接···" && ln -s $(pwd)/config/pip $XDG_CONFIG_HOME/pip)
[ -e "$XDG_CONFIG_HOME/wget" ] || (echo "创建 wget 软链接···" && ln -s $(pwd)/config/wget $XDG_CONFIG_HOME/wget)
[ -e "$XDG_CONFIG_HOME/npm" ] || (echo "创建 npm 软链接···" && ln -s $(pwd)/config/npm $XDG_CONFIG_HOME/npm)
[ -e "$XDG_CONFIG_HOME/python" ] || (echo "创建 python 软链接···" && ln -s $(pwd)/config/python $XDG_CONFIG_HOME/python)
[ -e "$XDG_CONFIG_HOME/nvim" ] || (echo "创建 nvim 软链接···" && ln -s $(pwd)/config/nvim $XDG_CONFIG_HOME/nvim)
[ -e "$XDG_CONFIG_HOME/git" ] || (echo "创建 git 软链接···" && ln -s $(pwd)/config/git $XDG_CONFIG_HOME/git)
[ -e "$OMZ" ] || (echo "创建 ohmyzsh 软链接···" && ln -s $(pwd)/data/ohmyzsh $OMZ)
if [ ! $is_wsl = "yes" ]; then
    [ -e "$XDG_CONFIG_HOME/hypr" ] || (echo "创建 hyprland 软链接···" && ln -s $(pwd)/config/hypr $XDG_CONFIG_HOME/hypr)
    [ -e "$XDG_CONFIG_HOME/waybar" ] || (echo "创建 waybar 软链接···" && ln -s $(pwd)/config/waybar $XDG_CONFIG_HOME/waybar)
fi

# vscode 配置
if [ -e "$HOME/.vscode-server" -a $is_overwrite = "yes" ]; then
    rm $HOME/.vscode-server/data/Machine/settings.json
    echo "创建 vscode-server settings.json 软链接···"
    ln -s $(pwd)/config/vscode/settings_wsl.json $HOME/.vscode-server/data/Machine/settings.json
fi

# zsh 插件
omz_plugin_path=$(pwd)/data/ohmyzsh/custom/plugins
if [ ! -e $omz_plugin_path/fzf-tab ]; then
    echo "克隆 fzf-tab 插件···"
    git clone https://github.com/Aloxaf/fzf-tab $omz_plugin_path/fzf-tab
fi

if [ ! -e $omz_plugin_path/z.lua ]; then
    echo "克隆 z.lua 插件···"
    git clone https://github.com/skywind3000/z.lua.git $omz_plugin_path/z.lua
fi

if [ ! -e $omz_plugin_path/zsh-autosuggestions ]; then
    echo "克隆 zsh-autosuggestions 插件···"
    git clone https://github.com/zsh-users/zsh-autosuggestions $omz_plugin_path/zsh-autosuggestions
fi

if [ ! -e $omz_plugin_path/zsh-completions ]; then
    echo "克隆 zsh-completions 插件···"
    git clone https://github.com/zsh-users/zsh-completions $omz_plugin_path/zsh-completions
fi

if [ ! -e $omz_plugin_path/zsh-history-substring-search ]; then
    echo "克隆 zsh-history-substring-search 插件···"
    git clone https://github.com/zsh-users/zsh-history-substring-search $omz_plugin_path/zsh-history-substring-search
fi

if [ ! -e $omz_plugin_path/zsh-syntax-highlighting ]; then
    echo "克隆 zsh-syntax-highlighting 插件···"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $omz_plugin_path/zsh-syntax-highlighting
fi

if [ ! -e $omz_plugin_path/conda-zsh-completion ]; then
    echo "克隆 conda-zsh-completion"
    git clone https://github.com/conda-incubator/conda-zsh-completion.git $omz_plugin_path/conda-zsh-completion
fi

omz_plugin_path=$(pwd)/data/ohmyzsh/custom/themes
if [ ! -e $omz_plugin_path/powerlevel10k ]; then
    echo "克隆 powerlevel10k 主题···"
    git clone --depth=1 https://gitee.com/romkatv/powerlevel10k.git $omz_plugin_path/powerlevel10k
fi
