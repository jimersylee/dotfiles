# Amazon Q pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"
# Q pre block. Keep at the top of this file.
# ghost
if [[ "$TERM_PROGRAM" == "ghostty" ]]; then
    export TERM=xterm-256color
fi
# 取消中英文切换的延迟
# hidutil property --set '{"CapsLockDelayOverride":0}'
# gemini
export GOOGLE_CLOUD_PROJECT="sylvan-server-424906-p8"
# http代理
export https_proxy=http://127.0.0.1:6152
export http_proxy=http://127.0.0.1:6152
export all_proxy=socks5://127.0.0.1:6153
# starship主题配置
eval "$(starship init zsh)"
# nvm配置
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
#[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
export EDITOR=/opt/homebrew/bin/nvim
#gvm配置
[[ -s "/Users/jimmy/.gvm/scripts/gvm" ]] && source "/Users/jimmy/.gvm/scripts/gvm"
#jenv
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"
# mysoftware
export PATH=/Users/jimmy/personal/software:$PATH
#homebrew
export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.aliyun.com/homebrew/homebrew-bottles
export HOMEBREW_API_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles/api"
export HOMEBREW_NO_AUTO_UPDATE=
# iterm2的插件
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
# bw
export BW_SESSION="z77tpkEN8OnLNW8GW3LeuuwQ2HgetnvXTvtBBW2GSztJWJM1uolbEvBcPBKzpYdXhl3cpO5IAOh1KYcEWotrgw=="
# conda
export PATH=/opt/homebrew/anaconda3/bin:$PATH
#curl,因为conda里也有curl, 使用这个curl覆盖下
export PATH="/opt/homebrew/opt/curl/bin:$PATH"
# qt5
export QT_HOMEBREW=true
export QT_API=5.13.0
# alias
alias gs='git status -s'
alias gc='git commit -m'
alias vim='nvim'
alias vi='vim'
#alias python3='python3.12'
# thefuck
eval $(thefuck --alias)
# pnpm
export PNPM_HOME="/Users/jimmy/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
# fig-dotfiles
[[ -f "$HOME/fig-export/dotfiles/dotfile.zsh" ]] && builtin source "$HOME/fig-export/dotfiles/dotfile.zsh"
# vince
export VINCE_INSTALL="$HOME/.vince"
export PATH="$VINCE_INSTALL/bin:$PATH"
# luamake
alias luamake="'/Users/jimmy/projects/luamake/luamake'"
# bun completions
[ -s "/Users/jimmy/.bun/_bun" ] && source "/Users/jimmy/.bun/_bun"
# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/jimmy/.lmstudio/bin"
# End of LM Studio CLI section

# kiro
[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path zsh)"

. "$HOME/.cargo/env"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/jimmy/.lmstudio/bin"
# End of LM Studio CLI section




[ ! -f "$HOME/.x-cmd.root/X" ] || . "$HOME/.x-cmd.root/X" # boot up x-cmd.

# Amazon Q post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh"
