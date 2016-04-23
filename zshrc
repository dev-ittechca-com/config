PAGER=less
EDITOR=vim
VISUAL=vim

LANG=en_US.UTF-8
LC_ALL=$LANG
LC_CTYPE=$LANG

HISTFILE=~/.zsh_history
HISTSIZE=9999
SAVEHIST=$HISTSIZE

autoload -U colors && colors
autoload -U compinit && compinit
autoload -U promptinit && promptinit

setopt alwaystoend
setopt autocd
setopt autopushd
setopt nobeep
setopt completeinword
setopt correct
setopt extendedglob
setopt extendedhistory
setopt histignorealldups
setopt histignorespace
setopt histreduceblanks
setopt nocaseglob
setopt nullglob
setopt listtypes

zstyle ':completion:*' auto-description 'specify %d'
zstyle ':completion:*' cache-path ~/.zsh_cache
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' file-sort modification reverse
zstyle ':completion:*' format 'completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' hosts off
zstyle ':completion:*' list-colors "=(#b) #([0-9]#)*=36=31"
zstyle ':completion:*' menu select=long-list select=0
zstyle ':completion:*' use-cache on
zstyle ':completion:*' verbose yes

PS1="%{$fg[red]%}%h %{$fg[yellow]%}%~ %{$reset_color%}% "
SPROMPT="$fg[red]%R$reset_color did you mean $fg[green]%r?$reset_color "

function png2jpg {
  for i in *.png ; do
    f=${i%.*}
    convert "$f.png" "$f.jpg"
  done
}

function colours {
  for i in {0..255}; do
    printf "\x1b[38;5;${i}mcolour${i}\n"
  done
}

function path {
  if [[ -d "$1" ]] ; then
    if [[ -z "$PATH" ]] ; then
      export PATH=$1
    else
      export PATH=$PATH:$1
    fi
  fi
}

export PATH=''
path /usr/local/sbin
path /usr/local/bin
path /sbin
path /bin
path /usr/sbin
path /usr/bin

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias grep="grep --color=always"
alias l="ls -lha --color"
alias ls="ls -lh --color"
alias md="mkdir -p"

alias web="chromium --proxy-server='127.0.0.1:8000'"

alias grep_ip="grep -Eo \
  '([0-9]{1,3}\.){3}[0-9]{1,3}'"
alias grep_url="grep -Eo \
  '(https?|ftp|file)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]'"
  
alias mac="openssl rand -hex 6|sed 's/\(..\)/\1:/g; s/.$//'"
alias rand="for i in {1..5} ; do \
  gpg --gen-random --armor 1 30 ; \
  openssl rand -base64 30 ; \
  cat /dev/urandom | base64 | cut -c-40 | head -n5 ; done"

alias gpg_restart="pkill gpg-agent ; pkill ssh-agent ; \
  eval $(gpg-agent --daemon --enable-ssh-support --use-standard-socket \
  --log-file ~/.gnupg/gpg-agent.log --write-env-file)"