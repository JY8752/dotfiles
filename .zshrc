# Amazon Q pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"

PROMPT='
%*'\$vcs_info_msg_0_'
%F{blue}[%~]%f %# '

# vim alias
alias vi="nvim"
alias vim="nvim"
alias view="nvim -R"

# git alias
alias add='git add'
alias commit='git commit'
alias pull='git pull'
alias push='git push'
alias st='git status'
alias stt='git status -uno'
alias cz='git-cz'

# other alias
alias ls='ls -A'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# ヒストリーに重複を表示しない
setopt histignorealldups

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# cdコマンドを省略して、ディレクトリ名のみの入力で移動
setopt auto_cd

# 他のターミナルとヒストリーを共有
setopt share_history

# 補完
autoload -Uz compinit
compinit

# 色を使用
autoload -Uz colors
colors

# 日本語を使用
export LANG=ja_JP.UTF-8

# ビープ音を鳴らさないようにする
setopt no_beep

export PATH="$PATH:$HOME/.foundry/bin"

# Add JBang to environment
alias j!=jbang
export PATH="$HOME/.jbang/bin:$PATH"

# direnv
export EDITOR=vim
eval "$(direnv hook zsh)"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# kubectlのalias
alias k=kubectl

# kubectl 補完
source <(kubectl completion zsh)

# helm 補完
source <(helm completion zsh)

# deno
export PATH="$HOME/.deno/bin:$PATH"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

function config_rprompt() {
  project_id=$(awk '/project/{print $3}' ~/.config/gcloud/configurations/config_default)
  PS1="%F{214}[${project_id}]%f $PS1"
}

# The following function is executed when the terminal is first started.
config_rprompt

function gpr() {
  project=$(gcloud projects list --format=json | jq -r '.[].projectId' | peco)
  gcloud config set project ${project}

  #config_rprompt
  source ~/.zshrc
}

# terraform
alias tf="terraform"

ssh-add --apple-use-keychain ~/.ssh/id_rsa > /dev/null 2>&1

alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"

alias gotest="gotestsum --format testdox"
alias gotestv="gotestsum --format standard-verbose"
alias gotestw="gotestsum --format testdox --watch"

# volta
export VOLTA_HOME=$HOME/.volta
export PATH="$VOLTA_HOME/bin:$PATH"

[ -f "$HOME/.ghcup/env" ] && . "$HOME/.ghcup/env" # ghcup-env
eval "$(rbenv init -)"

eval "$(starship init zsh)"
eval "$(sheldon source)"

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#767676"

# fzf
function fzf-select-history() {
    BUFFER=$(history -n -r 1 | fzf --query "$LBUFFER" --reverse)
    CURSOR=$#BUFFER
    zle reset-prompt
}
zle -N fzf-select-history
bindkey '^r' fzf-select-history

# bat
alias cat="bat"

# eza
alias l="eza"
alias la="eza -a --git -g -h --oneline --icons"
alias ll="eza -al --git --icons --time-style relative"

# ghq
function ghq-fzf() {
  local src=$(ghq list | fzf --preview "bat --color=always --style=header,grid --line-range :80 $(ghq root)/{}/README.*")
  if [ -n "$src" ]; then
    BUFFER="cd $(ghq root)/$src"
    zle accept-line
  fi
  zle -R -c
}
zle -N ghq-fzf
bindkey '^g' ghq-fzf

export PATH="$HOME/bin:$PATH"

# Amazon Q post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/opt/homebrew/share/google-cloud-sdk/path.zsh.inc' ]; then . '/opt/homebrew/share/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/opt/homebrew/share/google-cloud-sdk/completion.zsh.inc' ]; then . '/opt/homebrew/share/google-cloud-sdk/completion.zsh.inc'; fi
