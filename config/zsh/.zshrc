if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
source $ZDOTDIR/zshrc
# 判断终端是否为tty环境如果是则使用ascii字符，否则使用unicode字符
if [ $TERM = "linux" ]; then
  [[ ! -f $ZDOTDIR/.p10k_ascii.zsh ]] || source $ZDOTDIR/.p10k_ascii.zsh
else
  [[ ! -f $ZDOTDIR/.p10k_unicode.zsh ]] || source $ZDOTDIR/.p10k_unicode.zsh
fi