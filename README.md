## 安装步骤
1. 依赖安装
    ```bash
    # archlinux 系统
    sudo pacman -S lua fzf
    ```
2. 克隆仓库
    ```bash
    # 克隆本仓库
    git clone https://github.com/wuqin0202/dotfiles.git
    cd dotfiles
    # 克隆 ohmyzsh 仓库
    git submodule update --init --recursive
    ```
3. 开始安装
    ```bash
    ./install.sh
    chsh -s $(which zsh)
    ```