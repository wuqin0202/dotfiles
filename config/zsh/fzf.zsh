zstyle ':completion:complete:*:options' sort false # 不对结果排序
zstyle ':fzf-tab:complete:_zlua:*' query-string input # zlua 不对结果排序

zstyle ':fzf-tab:*' fzf-command fzf # 使用 fzf 命令