#! /bin/zsh

init_zsh() {
    # 下载 ohmyzsh
    omz_git_url="https://github.com/ohmyzsh/ohmyzsh.git"
    if [ -n $OMZ ]; then
        if [ -e $OMZ ]; then
            echo -n "OMZ 已经存在，是否覆盖？(y/[n]) "
            read is_overwrite
            if [ "$is_overwrite" = "y" ]; then
                trash put $OMZ
                git clone $omz_git_url $OMZ
            fi
        else
            git clone $omz_git_url $OMZ
        fi
    else
        echo "OMZ 环境变量不存在！"
        exit 1
    fi

    # 创建 ZDOTDIR 变量指定 zsh 配置配件路径
    if [ -z $ZDOTDIR ]; then
        ZDOTDIR=$HOME/.config/zsh
        echo -n "是否对所有用户有效（需要root权限）？(y/[n]) "
        read is_all_user
        echo "写入 ZDOTDIR 环境变量···"
        if [ "$is_all_user" = "y" ]; then
            if [ $EUID -eq 0 ]; then
                echo "export ZDOTDIR=$ZDOTDIR" >> /etc/zsh/zshenv
            else
                echo "export ZDOTDIR=$ZDOTDIR" | sudo tee -a /etc/zsh/zshenv > /dev/null
            fi
        else
            echo "export ZDOTDIR=$ZDOTDIR" >> $HOME/.zshenv
        fi
    fi

    # 安装 zsh 插件
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

    # 安装 zsh 主题
    omz_plugin_path=$OMZ/custom/themes
    if [ ! -e $omz_plugin_path/powerlevel10k ]; then
        echo "克隆 powerlevel10k 主题···"
        git clone --depth=1 https://gitee.com/romkatv/powerlevel10k.git $omz_plugin_path/powerlevel10k
    fi
}

init_dirs() {
    # 创建各环境变量的目录
    mkdir -p ${XDG_CONFIG_HOME} ${XDG_CACHE_HOME} ${XDG_DATA_HOME} ${XDG_STATE_HOME} # 创建 XDG 目录
    mkdir -p ${CONDA_ENVS_DIRS} # conda 有关目录
    mkdir -p ${HISTFILE%/*} ${_ZL_DATA%/*} # zsh 有关目录
    mkdir -p ${XDG_DATA_HOME}/npm ${XDG_CACHE_HOME}/npm # npm 有关目录
    mkdir -p ${GOPATH} ${GOBIN} ${_JAVA_OPTIONS#*=} ${GNUPGHOME} ${CARGO_HOME} # 其他程序
    mkdir -p ${HOME}/.local/bin
    mkdir -p ${HOME}/.ssh
    mkdir -p ${XDG_CONFIG_HOME}/systemd/user
    if [ ! -e "$XDG_STATE_HOME/python/history" ]; then
        echo "创建 python 历史记录文件···"
        mkdir -p $XDG_STATE_HOME/python
        touch $XDG_STATE_HOME/python/history
    fi
}

init() {
    init_zsh
    init_dirs
}

findMatchingDir() {
# 查找 config 目录下与参数匹配的目录
# 参数：
#   $1: 需要匹配的目录名
    if [ -z $1 ]; then
        echo "缺少参数，或者参数为空！"
        exit 1
    fi
    local directory="$proj_dir/config"
    local last_dir=$(basename $1)
    [[ $last_dir == .* ]] && last_dir="${last_dir#.}"
    local matching_dir=$(find "$directory" -type d -name "$last_dir" -print -quit)

    echo $matching_dir
}

updateDir() {
# 应用整个目录配置
# 参数：
# $1: 目标路径，需包含 config 目录下的目录名
# $2（可选）：sudo
    if [ ! -z $1 ]; then
        if [ ! -z $2 ] && [ "$2" != "sudo" ]; then
            echo "第二个参数只能为 sudo，不能为 $2"
            exit 1
        fi
        local config_dir_path=$(findMatchingDir $1)

        if [ -z $config_dir_path ]; then
            echo "未找到 $1 目录对应的配置目录！"
            exit 1
        fi

        if [ -e $1 ]; then
            echo -n "$1 目录已存在，是否覆盖？(y/[n])"
            read is_overwrite
            if [ "$is_overwrite" = "y" ]; then
                trash put $1 $2
                $2 cp -r $config_dir_path $1
            fi
        else
            echo "$1 目录不存在，创建···"
            $2 cp -r $config_dir_path $1
        fi
    else
        echo "缺少参数，或者参数为空！"
    fi
}

updateFile() {
# 应用单个文件配置
# 参数：
# $1: 目标路径，需包含 config 目录下的文件名
# $2（可选）：sudo
    if [ ! -z $1 ]; then
        if [ ! -z $2 ] && [ "$2" != "sudo" ]; then
            echo "第二个参数只能为 sudo，不能为 $2"
            exit 1
        fi
        local config_dir_path=$(findMatchingDir $1)

        if [ -z $config_dir_path ]; then
            echo "未找到 $1 目录对应的配置目录！"
            exit 1
        fi

        for file in $(ls $config_dir_path); do
            if [ -e $1/$file ]; then
                echo -n "$1/$file 配置文件已存在，是否覆盖？(y/[n])"
                read is_overwrite
                if [ "$is_overwrite" = "y" ]; then
                    trash put $1/$file $2
                    $2 cp $config_dir_path/$file $1/$file
                fi
            else
                echo "$1/$file 配置文件不存在，创建···"
                $2 cp $config_dir_path/$file $1/$file
            fi
        done
    else
        echo "缺少参数，或者参数为空！"
    fi
}

updateAll() {
    # 更新ohmyzsh
    if [ -e $OMZ ]; then
        cd $OMZ && git pull && cd -
    fi

    updateDir $ZDOTDIR
    updateDir $XDG_CONFIG_HOME/conda
    updateDir $XDG_CONFIG_HOME/pip
    updateDir $XDG_CONFIG_HOME/wget
    updateDir $XDG_CONFIG_HOME/npm
    updateDir $XDG_CONFIG_HOME/python
    updateDir $XDG_CONFIG_HOME/nvim
    updateDir $XDG_CONFIG_HOME/git
    updateFile $HOME/.ssh

    [ -n $DISPLAY ] && has_gui="yes" # 有无 GUI
    [ -n $(uname -r | grep -i "wsl") ] && is_wsl="yes" # 是否为 WSL
    command -v docker > /dev/null 2>&1 && has_docker="yes" # 是否有 docker

    # 有 GUI 且不是 WSL 情况
    if [ "$has_gui" = "yes" ] && [ "$is_wsl" != "yes" ]; then
        updateDir $XDG_CONFIG_HOME/hypr
        updateDir $XDG_CONFIG_HOME/waybar
    fi

    # WSL 情况

    # systemd 服务安装
    # 替换 systemd 目录下所有 .service 文件中的 ExecStart 行中的 data/scripts 字段
    mapfile -t service_files < <(find "$dir" -type f -name "*.service")
    for file in "${service_files[@]}"; do
        sed -i "s|ExecStart=.*data/scripts|ExecStart=/bin/bash $proj_dir/data/scripts|g" "$file"
    done
    if [ $EUID -eq 0 ]; then
        updateFile /etc/systemd/system
    else
        updateFile /etc/systemd/system sudo
    fi
    updateFile $XDG_CONFIG_HOME/systemd/user
    for file in "${service_files[@]}"; do
        sed -i "s|ExecStart=.*data/scripts|ExecStart=/bin/bash {/path/to/dotfiles}/data/scripts|g" "$file"
    done

    # docker 配置文件安装
    if [ "$has_docker" = "yes" ]; then
        if [ $EUID -eq 0 ]; then
            updateFile /etc/docker
        else
            updateFile /etc/docker sudo
        fi
    fi

    # 安装 data/scripts 目录下的脚本
    cp data/scripts/file_preview.sh ${HOME}/.local/bin

}

proj_dir=$(pwd)
if source $proj_dir/config/zsh/envs.zsh; then
    echo "source envs.zsh success"
else
    echo "source envs.zsh failed"
    exit 1
fi

case $1 in
    init)
        init
        ;;
    updateFile)
        updateFile $2
        ;;
    updateDir)
        updateDir $2
        ;;
    updateAll)
        updateAll
        ;;
    *)
        init && updateAll
        ;;
esac