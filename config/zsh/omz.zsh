ZSH=$OMZ
ZSH_THEME="powerlevel10k/powerlevel10k"
DISABLE_AUTO_TITLE=true # 是否禁用自动设置终端标题
plugins=( # 插件
    git
    fzf-tab
    zsh-syntax-highlighting
    zsh-autosuggestions
    zsh-history-substring-search
    zsh-completions
    conda-zsh-completion
    z.lua
)
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src # 见 https://github.com/zsh-users/zsh-completions#oh-my-zsh
source $OMZ/oh-my-zsh.sh
source $ZDOTDIR/fzf.zsh
autoload -U compinit && compinit