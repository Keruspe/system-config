# Load interresting modules
autoload -Uz compinit colors vcs_info

# Setup env
. /etc/profile.env

setopt nullglob
for sh in /etc/profile.d/*.sh ; do
    [ -r "$sh" ] && . "$sh"
done
unset sh
unsetopt nullglob

# Basic settings
HISTFILE=~/.histfile
HISTSIZE=8192
SAVEHIST=8192
export EDITOR=/usr/bin/vim
export PAGER=/usr/bin/less
export PATH="/usr/sbin:/sbin:/usr/bin:/bin:${PATH}"
umask 022

# Completions

## format all messages not formatted in bold prefixed with ----
zstyle ':completion:*' format '%B---- %d%b'
## format descriptions (notice the vt100 escapes)
zstyle ':completion:*:descriptions'    format $'%{\e[0;31m%}completing %B%d%b%{\e[0m%}'
## bold and underline normal messages
zstyle ':completion:*:messages' format '%B%U---- %d%u%b'
## format in bold red error messages
zstyle ':completion:*:warnings' format "%B$fg[red]%}---- no match for: $fg[white]%d%b"
## let's use the tag name as group name
zstyle ':completion:*' group-name ''
## activate menu selection
zstyle ':completion:*' menu select=long
## activate approximate completion, but only after regular completion (_complete), prefer expansion
zstyle ':completion:::::' completer _expand _complete _ignored _history _correct _approximate
## limit to 2 errors
zstyle ':completion:*:approximate:*' max-errors 2
## Better handling of long output
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more %s

# Enable a few things
compinit
colors

setopt autocd appendhistory extendedglob nonomatch promptsubst notify

# vim mode
bindkey -v

# Ctrl-R to search history
bindkey '^R' history-incremental-search-backward

# VCS info
zstyle ':vcs_info:*' actionformats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f '
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'
zstyle ':vcs_info:*' enable git hg bzr svn

## Reload vcs_info stuff on precmd
precmd(){
    vcs_info
    [[ $(tty) = /dev/pts/* ]] && print -Pn "\e]0;%n@%M:%~\a"
}

# Aliases
alias ls='ls --color=auto'
alias lo='ls -ogh'
alias ll='ls -lh'
alias ssh='autossh -M 0'
alias grep='grep --colour=auto'
sudo() {
    su - -c "$@"
}

# No beep ever
unsetopt beep

# Prompts
PROMPT='%M %{${fg[blue]}%}%~ ${vcs_info_msg_0_}%# %{${reset_color}%}'
RPROMPT="%{${fg[blue]}%}[%{${fg[red]}%}%?%{${fg[blue]}%}][%{${fg[red]}%}%*%{${fg[blue]}%} - %{${fg[red]}%}%D{%d/%m/%Y}%{${fg[blue]}%}]%{${reset_color}%}"

if [ "$EUID" = "0" ] || [ "$USER" = "root" ] ; then
    PROMPT="%{${fg_bold[red]}%}${PROMPT}"
else
    PROMPT="%{${fg_bold[green]}%}%n@${PROMPT}"
fi

