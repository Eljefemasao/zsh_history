
export GNUTERM=aqua
export EDITOR=emacs 
export PATH=/usr/local/bin:$PATH
export PATH=/bin:$PATH
export PATH=/sbin:$PATH
export PATH=/usr/sbin:$PATH
export PATH=/usr/bin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export PATH=/usr/local/bin/brew:$PATH
export PATH=~/anaconda/bin:/Users/masaaki/bin:$PATH
#export WORKON_HOME=$HOME/.virtualenvs
#source `which virtualenvwrapper.sh`
export VIRTUALENV_USE_DISTRIBUTE=true
export PATH=~/.nodebrew/current/bin:$PATH
export PATH=/Applications/MAMP/Library/bin:$PATH


PYENV_ROOT=~/.pyenv
export PATH=$PYENV_ROOT/bin:$PATH
eval "$(pyenv init -)"


alias e='emacs'
# UTF-8
export LANG=ja_JP.UTF-8

# COREを作らない
ulimit -c 0

# Emacs ライクな操作を有効にする（文字入力中に Ctrl-F,B でカーソル移動など）
bindkey -e

# autoloadされる関数を検索するパス
fpath=(~/.zfunc $fpath)
fpath=(~/.git_completion $fpath)
fpath=(~/.zsh.d/anyframe(N-/) $fpath)

# zsh plugin
autoload -Uz anyframe-init
#anyframe-init

# 履歴の保存先と保存数
HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

# 色の設定
local DEFAULT=$'%{^[[m%}'$
local RED=$'%{^[[1;31m%}'$
local GREEN=$'%{^[[1;32m%}'$
local YELLOW=$'%{^[[1;33m%}'$
local BLUE=$'%{^[[1;34m%}'$
local PURPLE=$'%{^[[1;35m%}'$
local LIGHT_BLUE=$'%{^[[1;36m%}'$
local WHITE=$'%{^[[1;37m%}'$

export LSCOLORS=exfxcxdxbxegedabagacad
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
#pt hist_ignore_all_dups
# コマンドがスペースで始まる場合、コマンド履歴に追加しない
setopt hist_ignore_space
# 補完キー連打で順に補完候補を自動で補完
setopt auto_menu
# 拡張グロブで補完(~とか^とか。例えばless *.txt~memo.txt ならmemo.txt 以外の *.txt にマッチ)
setopt extended_glob
# Beepを鳴らさない
setopt no_beep
setopt no_list_beep
# 補完候補を詰めて表示
setopt list_packed
# このオプションが有効な状態で、ある変数に絶対パスのディレクトリを設定すると、即座にその変数の名前が
# ディレクトリの名前になり、すぐにプロンプトに設定している'%~'やcdコマンドの'~'での補完に反映されるようになる。
setopt auto_name_dirs
# 補完実行時にスラッシュが末尾に付いたとき、必要に応じてスラッシュを除去する
setopt auto_remove_slash
# 行の末尾がバッククォートでも無視する
setopt sun_keyboard_hack
# 補完候補一覧でファイルの種別を識別マーク表示(ls -F の記号)
setopt list_types
# 補完のときプロンプトの位置を変えない
setopt always_last_prompt
le ':completion:*:cd:*' ignore-parents parent pwd
# 大文字小文字を区別しない
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# 履歴
alias his=anyframe-widget-execute-history
# cd
alias cdd=anyframe-widget-cdr
# select history
function peco-select-history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(\history -n 1 | \
        eval $tac | \
        peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history

# cdr
autoload -Uz is-at-least
if is-at-least 4.3.11
then
  autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
  add-zsh-hook chpwd chpwd_recent_dirs
  zstyle ':chpwd:*'      recent-dirs-max 1000
  zstyle ':chpwd:*'      recent-dirs-default yes
  zstyle ':completion:*' recent-dirs-insert both
fi

# ブランチ名を表示する
function __git_branch() {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\:\1/'
}
alias gbn=__git_branch


# 色の設定
if [ `uname` = "FreeBSD" ]; then
  alias ls='ls -GF'
  alias ll='ls -alGF'
elif [ `uname` = "Darwin" ]; then
  alias ls='ls -GF'
  alias ll='ls -alGF'
else
  alias ls='ls -F --color=auto'
  alias ll='ls -alF --color=auto'
fi

# プロンプト
setopt prompt_subst
if [ `whoami` = "root" ]; then
  PROMPT='[%F{red}%n@%m%F{default}]# '
else
  PROMPT='[%m$(gbn)]# '
fi
RPROMPT='[%F{green}%d%f%F{default}]'

# スクリーン起動



if [ "$WINDOW" = "" ] ; then
  screen
fi

function preexec() {
  if [ $TERM_PROGRAM = 'iTerm.app' ]; then
    mycmd=(${(s: :)${1}})
    echo -ne "\ek$(hostname|awk 'BEGIN{FS="."}{print $1}'):$mycmd[1]\e\\"
  fi
}
function precmd() {
  if [ $TERM_PROGRAM = 'iTerm.app' ]; then
    echo -ne "\ek$(hostname|awk 'BEGIN{FS="."}{print $1}'):idle\e\\"
  fi
}














