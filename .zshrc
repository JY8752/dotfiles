# CodeWhisperer pre block. Keep at the top of this file.
#[[ -f "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.pre.zsh"
PROMPT='
%*'\$vcs_info_msg_0_'
%F{blue}[%~]%f %# '

# git設定
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{magenta}+"
zstyle ':vcs_info:*' formats "%F{cyan}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd(){ vcs_info }

#nodenv
# eval "$(nodenv init - --no-rehash)"

#java
#export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

#jenv
# export PATH="$HOME/.jenv/bin:$PATH"
# eval "$(jenv init -)"

# vim alias
alias vi="nvim"
alias vim="nvim"
alias view="nvim -R"

# git alias
alias pull='git pull'
alias push='git push'
alias st='git status'
alias stt='git status -uno'

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

export PATH="$PATH:/Users/yamanakajunichi/.foundry/bin"

# Add JBang to environment
alias j!=jbang
export PATH="$HOME/.jbang/bin:$PATH"

# direnv
export EDITOR=vim
eval "$(direnv hook zsh)"

# graal
# export PATH=/Library/Java/JavaVirtualMachines/graalvm-ce-java17-22.2.0/Contents/Home/bin:"$PATH"
# export GRAALVM_HOME=/Library/Java/JavaVirtualMachines/graalvm-ce-java17-22.2.0/Contents/Home

# export JAVA_HOME=$GRAALVM_HOME

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
# export SDKMAN_DIR="$HOME/.sdkman"
# [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# キーボードアシスト
alias chkey="open /System/Library/CoreServices/KeyboardSetupAssistant.app"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/yamanakajunichi/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/yamanakajunichi/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/yamanakajunichi/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/yamanakajunichi/google-cloud-sdk/completion.zsh.inc'; fi

# kubectlのalias
alias k=kubectl

# kubectl 補完
source <(kubectl completion zsh)

# kube-ps1
source "/opt/homebrew/opt/kube-ps1/share/kube-ps1.sh"
PS1='$(kube_ps1)'$PS1

# helm 補完
source <(helm completion zsh)

# asdf

# asdfの補完
. /opt/homebrew/opt/asdf/libexec/asdf.sh
fpath=($(brew --prefix asdf)/completions $fpath)
autoload -Uz compinit && compinit

# asdfのJAVA_HOMEを設定
. ~/.asdf/plugins/java/set-java-home.zsh

# asdfのGOROOTを設定
. ~/.asdf/plugins/golang/set-env.zsh

#go
# export GOPATH=/Users/yamanakajunichi  # GOPATHにすると決めた場所
export PATH=$(go env GOPATH)/bin:$PATH

# deno
export PATH="/Users/yamanakajunichi/.deno/bin:$PATH"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# bun completions
[ -s "/Users/yamanakajunichi/.bun/_bun" ] && source "/Users/yamanakajunichi/.bun/_bun"

# CodeWhisperer post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.post.zsh"

# Google Cloud
#
# function config_rprompt() {
#   project_id=$(gcloud config configurations list --format=json | jq -r '.[] | select(.is_active == true) | .properties.core.project')
#   RPROMPT=%F{032}[${project_id}]%f
# }

function config_rprompt() {
  project_id=$(awk '/project/{print $3}' ~/.config/gcloud/configurations/config_default)
  PS1="%F{214}[${project_id}]%f $PS1"
}

# The following function is executed when the terminal is first started.
config_rprompt

function gpr() {
  project=$(gcloud projects list --format=json | jq -r '.[].projectId' | peco)
  gcloud config set project ${project}

  config_rprompt
}
