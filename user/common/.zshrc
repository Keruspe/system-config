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

# Setup GPG env
export GPG_TTY=$(tty)
unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
    export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/gnupg/S.gpg-agent.ssh"
fi

# Ensure ibus is running
if [[ "${EUID}" != "0" ]]; then
    gdbus introspect -e -d org.freedesktop.IBus -o /org/freedesktop/IBus &>/dev/null
fi

# Basic settings
HISTFILE=~/.histfile
HISTSIZE=8192
SAVEHIST=8192
export EDITOR=/usr/bin/vim
export PAGER=/usr/bin/less
export PATH=~/bin:~/.local/bin:${PATH}
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
zstyle ':completion:::::' completer _expand _complete _ignored _correct _approximate
## limit to 2 errors
zstyle ':completion:*:approximate:*' max-errors 2
## Better handling of long output
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more %s

# Drop completions cache
rm -f ~/.zcompdump

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

## Reload vcs_info stuff on precmd and ensure gpg is running
precmd(){
    vcs_info
    [[ $(tty) = /dev/pts/* ]] && print -Pn "\e]0;%n@%M:%~\a"
}

# Aliases
alias ls='ls --color=auto'
alias lo='ls -ogh'
alias ll='ls -lh'
alias grep='grep --colour=auto'
sudo() {
    su - -c "$@"
}
r() {
    cave sync -s local $1 && shift && cave resolve -x1z $@
}
delete_repo() {
    rm -rf /etc/paludis/repositories/"${1}".conf /var/db/paludis/repositories/"${1}"/ /var/cache/paludis/names/"${1}"/ /var/cache/paludis/metadata/"${1}"/
}
init_node() {
    local last
    if [[ -z "${NVM_DIR}" ]]; then
        . ~/.nvm/nvm.sh
        last="$(nvm_remote_versions | grep -v iojs | tail -1)"
        nvm install "${last}" &>/dev/null
        command clever &>/dev/null || npm install -g clever-tools
    fi
}
clever() {
    init_node
    command clever "${@}"
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
