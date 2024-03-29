#! /bin/zsh

init() {
    # ohmyzsh
    if [ -n $OMZ ]; then
        if [ -e $OMZ ]; then
            echo -n "OMZ 已经存在，是否覆盖？(y/[n]) "
            read is_overwrite
            if [ "$is_overwrite" = "y" ]; then
                saferm $OMZ
                git clone https://github.com/ohmyzsh/ohmyzsh.git $OMZ
            fi
        else
            git clone https://github.com/ohmyzsh/ohmyzsh.git $OMZ
        fi
    else
        echo "OMZ 环境变量不存在！"
        exit 1
    fi

    # 若没有则创建 ZDOTDIR 变量
    if [ -z $ZDOTDIR ]; then
        ZDOTDIR=$HOME/.config/zsh
        echo "写入 ZDOTDIR 环境变量···"
        echo "export ZDOTDIR=$ZDOTDIR" | sudo tee -a /etc/zsh/zshenv > /dev/null
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

    # zsh 插件
    omz_plugin_path=$OMZ/custom/plugins
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

    # zsh 主题
    omz_plugin_path=$OMZ/custom/themes
    if [ ! -e $omz_plugin_path/powerlevel10k ]; then
        echo "克隆 powerlevel10k 主题···"
        git clone --depth=1 https://gitee.com/romkatv/powerlevel10k.git $omz_plugin_path/powerlevel10k
    fi
}

saferm() {
    if [ ! -z $2 ] && [ "$2" != "sudo" ]; then
        echo "第二个参数只能为 sudo，不能为 $2"
        exit 1
    fi

    backup_dir=$HOME/.backup

    if [ ! -e $backup_dir ]; then
        echo "创建备份目录···"
        mkdir $backup_dir
    fi

    if [ -e $1 ]; then
        echo "备份 $1···"
        $2 mv -i $1 $backup_dir
    fi
}

update() {
    # 第一个参数为 config 目录下的配置文件路径
    # 第二个参数为是否需要 sudo
    if [ ! -z $1 ]; then
        if [ ! -z $2 ] && [ "$2" != "sudo" ]; then
            echo "第二个参数只能为 sudo，不能为 $2"
            exit 1
        fi
        local name=$(basename $1)
        if [ -e $1 ]; then
            echo -n "$name 配置文件已存在，是否覆盖？(y/[n])"
            read is_overwrite
            if [ "$is_overwrite" = "y" ]; then
                saferm $1 $2
                $2 cp -r $(pwd)/config/$name $1
            fi
        else
            echo "$name 配置文件不存在，创建···"
            $2 cp -r $(pwd)/config/$name $1
        fi
    else
        echo "缺少参数，或者参数为空！"
    fi
}

updateAll() {
    # 更新ohmyzsh
    if [ -e $OMZ ]; then
        cd $OMZ && git pull && cd -
    fi

    update $ZDOTDIR
    update $XDG_CONFIG_HOME/conda
    update $XDG_CONFIG_HOME/pip
    update $XDG_CONFIG_HOME/wget
    update $XDG_CONFIG_HOME/npm
    update $XDG_CONFIG_HOME/python
    update $XDG_CONFIG_HOME/nvim
    update $XDG_CONFIG_HOME/git

    [ -n $DISPLAY ] && has_gui="yes" # 有无 GUI
    [ -n $(uname -r | grep -i "wsl") ] && is_wsl="yes" # 是否为 WSL
    command -v docker > /dev/null 2>&1 && has_docker="yes" # 是否有 docker

    # 有 GUI 且不是 WSL 情况
    if [ "$has_gui" = "yes" ] && [ "$is_wsl" != "yes" ]; then
        update $XDG_CONFIG_HOME/hypr
        update $XDG_CONFIG_HOME/waybar
    fi

    # WSL 情况

    # 需要 root 权限情况
    [ "$has_docker" = "yes" ] && update /etc/docker sudo
}

if source $(pwd)/config/zsh/envs.zsh; then
    echo "source envs.zsh success"
else
    echo "source envs.zsh failed"
    exit 1
fi

case $1 in
    init)
        init
        ;;
    update)
        update $2
        ;;
    updateAll)
        updateAll
        ;;
    *)
        init && updateAll
        ;;
esac