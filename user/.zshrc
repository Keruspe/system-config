# /etc/zsh/zprofile
# $Header: /var/cvsroot/gentoo-x86/app-shells/zsh/files/zprofile,v 1.5 2008/05/23 12:02:51 tove Exp $

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' completions 1
zstyle ':completion:*' glob 1
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' max-errors 1
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' substitute 1
autoload -Uz compinit colors
compinit
colors
HISTFILE=~/.histfile
HISTSIZE=2048
SAVEHIST=2048
setopt appendhistory autocd extendedglob notify nonomatch PROMPT_SUBST
unsetopt beep
bindkey -v

# Load environment settings from profile.env, which is created by
# env-update from the files in /etc/env.d
if [ -e /etc/profile.env ] ; then
	. /etc/profile.env
fi

# You should override these in your ~/.zprofile (or equivalent) for per-user
# settings.  For system defaults, you can add a new file in /etc/profile.d/.
export EDITOR=${EDITOR:-/usr/bin/vim}
export PAGER=${PAGER:-/usr/bin/less}

# 077 would be more secure, but 022 is generally quite realistic
umask 022

# Set up PATH depending on whether we're root or a normal user.
# There's no real reason to exclude sbin paths from the normal user,
# but it can make tab-completion easier when they aren't in the
# user's PATH to pollute the executable namespace.
#
# It is intentional in the following line to use || instead of -o.
# This way the evaluation can be short-circuited and calling whoami is
# avoided.

autoload -Uz vcs_info

zstyle ':vcs_info:*' actionformats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f '
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'
zstyle ':vcs_info:*' enable git hg bzr svn

PROMPT='%M %{${fg[blue]}%}%~ ${vcs_info_msg_0_}%# %{${reset_color}%}'

if [ "$EUID" = "0" ] || [ "$USER" = "root" ] ; then
	PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:${ROOTPATH}"
	PROMPT="%{${fg_bold[red]}%}${PROMPT}"
else
	PATH="/usr/local/bin:/usr/bin:/bin:${PATH}"
	PROMPT="%{${fg_bold[green]}%}%n@${PROMPT}"
fi
export PATH
unset ROOTPATH

alias ls='ls --color=auto'
alias lo='ls -ogh'
alias ll='ls -lh'
alias ssh='autossh -M 0'
alias grep='grep --colour=auto'
sudo() {
    su - -c "$@"
}

precmd(){
    vcs_info
    [[ $(tty) = /dev/pts/* ]] && print -Pn "\e]0;%n@%M:%~\a"
}

shopts=$-
setopt nullglob
for sh in /etc/profile.d/*.sh ; do
	[ -r "$sh" ] && . "$sh"
done
unsetopt nullglob
set -$shopts
unset sh shopts

RPROMPT="%{${fg[blue]}%}[%{${fg[red]}%}%?%{${fg[blue]}%}][%{${fg[red]}%}%*%{${fg[blue]}%} - %{${fg[red]}%}%D{%d/%m/%Y}%{${fg[blue]}%}]%{${reset_color}%}"

