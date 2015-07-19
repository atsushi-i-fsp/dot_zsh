# Created by newuser for 4.3.10

## プロンプトの設定
autoload colors
colors

PROMPT="%{${fg[yellow]}%}[%n@%m] %{${fg[green]}%}%(!.#.$) %{${reset_color}%}"
PROMPT2="%{${fg[blue]}%}%_> %{${reset_color}%}"
SPROMPT="%{${fg[red]}%}correct: %R -> %r [nyae]? %{${reset_color}%}"
RPROMPT="%{${fg[yellow]}%}[%~]%{${reset_color}%}"

# エイリアス
alias ls="ls -F --color"
alias ll='ls -laF --color | more'
alias rm="rm -i"
alias h='history -E -32'
alias nfsmount='sudo mount -t nfs 192.168.24.51:/home/atsushi/export ~atsushi/nfs_shared'
alias nfsumount='sudo umount ~atsushi/nfs_shared'
alias emacs-server='XMODIFIERS=@im=none /usr/bin/emacs'
alias emacs='emacsclient'
#alias term='gnome-terminal --geometry=180x40'
#alias smbm='sudo smbmount //192.168.24.53/share ~/samba -o guest'
#alias smbum='sudo smbumount ~/samba'
#alias boot_minix='qemu -localtime -net user -net nic -m 256 -hda ~/Work/minix/minix.img'
alias diff='colordiff'
alias cleanup='rm *~ \#*\# -f'
alias cleanup_all='find . \( -name "*~" -o -name "\#*\#" \) | xargs rm'
alias df='df -h |column -t'
alias vls='/usr/share/vim/vim72/macros/less.sh'

function search() {
  if [ $# -lt 1 ] ; then
      print "error: few args!"
      return 0
  elif [ $# -eq 1 ] ; then
      arg1="*"
      arg2=$1
  else
      arg1=$1
      arg2=$2
  fi

  find . -name $arg1 -print | xargs grep $arg2
}

# 環境変数
export M3_HOME=/usr/local/lib/apache-maven-3.2.3
export PATH=$PATH:/usr/lib/postgresql/8.3/bin:$HOME/bin:$M3_HOME/bin
export EDITOR=emacsclient
export VISUAL=emacsclient

## Keybind configuration
#
# emacs like keybind (e.x. Ctrl-a goes to head of a line and Ctrl-e goes 
#   to end of it)
#
bindkey -e
 
# historical backward/forward search with linehead string binded to ^P/^N
#
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups
setopt share_history


# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/atsushi/.zshrc'
zstyle ':completion:*' list-colors 'di=01;34' 'ln=01;36' 'pi=40;33' 'so=01;35' 'do=01;35' 'bd=40;33;01' 'cd=40;33;01'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# rvm
if [[ -s $HOME/.rvm/scripts/rvm ]] ; then source $HOME/.rvm/scripts/rvm ; fi
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# nvm
if [[ -s ~/.nvm/nvm.sh ]];
 then source ~/.nvm/nvm.sh
fi

#############################################################################
##
## オプションの設定
##
#############################################################################
# コマンドの開始時刻と経過時間を登録
setopt extended_history
# 補完候補一覧でファイルの種別を識別マーク表示(ls -F の記号)
setopt list_types
# 勝手にpushdしておいてくれる。popdだけでいけるようになる。
setopt autopushd
# --prefix=の後のパス名を補完したり
setopt magic_equal_subst
# ワイルドカード展開時、マッチするパターンがない時にエラー中断しない
setopt nonomatch

#############################################################################
##
## キーバインドの設定
##
#############################################################################
# カーソル位置から前方削除(Ctrl-u)
bindkey '^U' backward-kill-line
# カーソルの単語単位での移動（Ctrl+左右カーソルキー）
bindkey ";5C" forward-word
bindkey ";5D" backward-word
export WORDCHARS='*?[]~=&;!#$%^(){}<>'


#############################################################################
##
## その他 
##
#############################################################################
# makeとかの出力に色付け
e_normal=`echo -e "\033[0;30m"`
e_RED=`echo -e "\033[1;31m"`
e_BLUE=`echo -e "\033[1;36m"`

function make() {
    LANG=C command make "$@" 2>&1 | sed -e "s@[Ee]rror:.*@$e_RED&$e_normal@g" -e "s@cannot\sfind.*@$e_RED&$e_normal@g" -e "s@[Ww]arning:.*@$e_BLUE&$e_normal@g"
}
function cwaf() {
    LANG=C command ./waf "$@" 2>&1 | sed -e "s@[Ee]rror:.*@$e_RED&$e_normal@g" -e "s@cannot\sfind.*@$e_RED&$e_normal@g" -e "s@[Ww]arning:.*@$e_BLUE&$e_normal@g"
}
