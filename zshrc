#---zplugin start---
export ZPLUG_HOME=/opt/homebrew/opt/zplug
source $ZPLUG_HOME/init.zsh

autoload -U promptinit; promptinit
# プロンプトを変更
prompt pure



setopt auto_cd
setopt auto_param_slash      # ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt mark_dirs             # ファイル名の展開でディレクトリにマッチした場合 末尾に / を付加
setopt list_types            # 補完候補一覧でファイルの種別を識別マーク表示 (訳注:ls -F の記号)
setopt auto_menu             # 補完キー連打で順に補完候補を自動で補完
setopt auto_param_keys       # カッコの対応などを自動的に補完
setopt interactive_comments  # コマンドラインでも # 以降をコメントと見なす
setopt magic_equal_subst     # コマンドラインの引数で --prefix=/usr などの = 以降でも補完できる

setopt complete_in_word      # 語の途中でもカーソル位置で補完
setopt always_last_prompt    # カーソル位置は保持したままファイル名一覧を順次その場で表示

setopt print_eight_bit  #日本語ファイル名等8ビットを通す
setopt extended_glob  # 拡張グロブで補完(~とか^とか。例えばless *.txt~memo.txt ならmemo.txt 以外の *.txt にマッチ)
setopt globdots # 明確なドットの指定なしで.から始まるファイルをマッチ
compinit
_comp_options+=(globdots)

zplug 'zsh-users/zsh-autosuggestions', defer:2 
zplug 'zsh-users/zsh-completions'
zplug 'zsh-users/zsh-syntax-highlighting', defer:2
zplug "mollifier/anyframe"
zplug "mollifier/cd-gitroot"
# zplug "b4b4r07/enhancd", use:enhancd.sh
zplug "zsh-users/zsh-history-substring-search", hook-build:"__zsh_version 4.3"
#zplug "junegunn/fzf", as:command, use:bin/fzf-tmux
#zplug 'supercrabtree/k'
zplug "junegunn/fzf", use:shell/key-bindings.zsh
zplug "junegunn/fzf", use:shell/completion.zsh
zplug "paulirish/git-open", as:plugin
: "cd先のディレクトリのファイル一覧を表示する" && {
  [ -z "$ENHANCD_ROOT" ] && function chpwd { tree -L 1 } # enhancdがない場合
  [ -z "$ENHANCD_ROOT" ] || export ENHANCD_HOOK_AFTER_CD="tree -L 1" # enhancdがあるときはそのHook機構を使う
}

#enhanced
#zplug "b4b4r07/enhancd", use:enhancd.sh
#zplug "b4b4r07/enhancd", use:init.sh

zplug "junegunn/fzf", as:command, use:bin/fzf-tmux

#ftz & peco
zplug "junegunn/fzf-bin", as:command, from:gh-r, rename-to:fzf
zplug "junegunn/fzf", as:command, use:bin/fzf-tmux
# fzf-tmux の peco バージョン
zplug "b4b4r07/dotfiles", as:command, use:bin/peco-tmux


: "sshコマンド補完を~/.ssh/configから行う" && {
  function _ssh { compadd $(fgrep 'Host ' ~/.ssh/*/config | grep -v '*' |  awk '{print $2}' | sort) }
}

#速度上昇のためにコメントアウト
# 未インストール項目をインストールする
#if ! zplug check --verbose; then
#    printf "Install? [y/N]: "
#    if read -q; then
#        echo; zplug install
#    fi
#fi

# コマンドをリンクして、PATH に追加し、プラグインは読み込む
zplug load --verbose

#---zplugin end---

#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# for curl no match found
setopt nonomatch

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
export PATH=/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Users/56-11628/.nodebrew/current/bin:/usr/local/bin:/usr/local/sbin
#
autoload -U +X bashcompinit && bashcompinit

#for terraform
alias t=terraform
complete -o nospace -C /usr/local/bin/terraform terraform

#for command
alias p=pwd
alias ll='ls -lah'
alias cat='bat'
alias find='fd'


#for git
alias g=git

#for pip update library
alias pip-l-update='pip install -U $(pip list -o | awk '{print $1}' | tail -n +3) '

function peco-history-selection() {
    BUFFER=`history -n 1 | tail -r  | awk '!a[$0]++' | peco`
    CURSOR=$#BUFFER
    zle reset-prompt
}

zle -N peco-history-selection
bindkey '^R' peco-history-selection


#for debug speed
#if (which zprof > /dev/null 2>&1) ;then
#  zprof
#fi


