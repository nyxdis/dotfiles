# teh profile
. ${EPREFIX}/etc/zsh/zprofile

# ubuntu command-not-found handler
[ -f /etc/zsh_command_not_found ] && . /etc/zsh_command_not_found

# keychain
[ $(whence keychain) ] && eval `keychain -q --eval id_rsa id_dsa`

# produce core dumps
#ulimit -c unlimited

export EDITOR="vim"
export GENTOO_AUTHOR_EMAIL="angelos@gentoo.org"
export GENTOO_AUTHOR_NAME="Christoph Mende"
export GOPATH="${HOME}/proj/go"
export GRADLE_HOME="${HOME}/gradle-2.1"
export LESS="-R"
#export MPD_HOST=raspbmc.local
export PATH="${HOME}/bin:${HOME}/.local/bin:${GOPATH}/bin:${GRADLE_HOME}/bin:${PATH}"
#export VDPAU_DRIVER="va_gl"
#eval "$(lesspipe)"

if [ "$TERM" = "xterm" ] ; then
    if [ -z "$COLORTERM" ] ; then
        if [ -n "$VTE_VERSION" ] ; then
            TERM="gnome-256color"
        elif [ -z "$XTERM_VERSION" ] ; then
            echo "Warning: Terminal wrongly calling itself 'xterm'."
        else
            case "$XTERM_VERSION" in
            "XTerm(256)") TERM="xterm-256color" ;;
            "XTerm(88)") TERM="xterm-88color" ;;
            "XTerm") ;;
            *)
                echo "Warning: Unrecognized XTERM_VERSION: $XTERM_VERSION"
                ;;
            esac
        fi
    else
        case "$COLORTERM" in
            gnome-terminal|Terminal|xfce4-terminal)
                # Those crafty Gnome folks require you to check COLORTERM,
                # but don't allow you to just *favor* the setting over TERM.
                # Instead you need to compare it and perform some guesses
                # based upon the value. This is, perhaps, too simplistic.
                TERM="gnome-256color"
                ;;
            *)
                echo "Warning: Unrecognized COLORTERM: $COLORTERM"
                ;;
        esac
    fi
fi

# for lame non-UTF8 systems
if [[ ${LANG} != *utf8 ]] && [[ ${LANG} != *UTF-8 ]]; then
	export LANG=en_US.utf8
	export LC_ALL=en_US.utf8
fi

# Completion
autoload -U compinit
compinit
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate

# colors
autoload -Uz colors && colors

eval `dircolors -b ~/.dircolors-256dark`

zstyle ':completion:*' list-colors ''
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# Completion Cache
#zstyle ':completion::complete:*' use-cache 1

# Prompt
export PROMPT="%{%B%2F%}%n@%m%{%f%b%}:%{%B%4F%}%~%{%b%f%}%# "
#export PROMPT="%. %# "
#autoload -U promptinit
#promptinit
#prompt gentoo


## Options
# Changing Directories
setopt AUTO_CD PUSHD_TO_HOME
# History
setopt APPEND_HISTORY HIST_EXPIRE_DUPS_FIRST HIST_IGNORE_ALL_DUPS
# nasty bug that hangs new shells
if ! [ $ZSH_VERSION = 5.0.6 ]; then
	setopt HIST_FCNTL_LOCK
fi
setopt HIST_REDUCE_BLANKS SHARE_HISTORY HIST_IGNORE_SPACE
# Initialisation
setopt RCS
# Input/Output
setopt MAIL_WARNING
# Job Control
setopt NO_HUP NO_CHECK_JOBS
# Zle
setopt NO_BEEP

zshexit() { clear }

# .ssh/known_hosts completion
if [ -e ~/.ssh/known_hosts ] ; then
	local _myhosts
	_myhosts=( ${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[0-9]*}%%\ *}%%,*} )
	zstyle ':completion:*' hosts $_myhosts
fi

# Aliases
alias cdrecord='cdrecord -v -eject dev=/dev/sr0'
alias diff='diff -u'
alias grep='egrep --color=auto'
alias leak='valgrind --leak-check=full --show-reachable=yes'
alias ls='ls -F --color=auto'
alias ll='ls -l'
alias la='ls -lA'
alias mv='mv -i'
alias cp='cp -i'
alias rm='rm -i'
alias pcheck='pcheck -r portdir -a amd64'
alias rec='ffmpeg -f video4linux2 -i /dev/video0 tmp.mpeg'
alias rtorrent='screen -S rtorrent rtorrent'
alias sqlite3='sqlite3 -column -header'
alias cnl='ssh -Nf -L9666:localhost:9666 rpi'
alias autopurge="dpkg -l | egrep -q ^rc && dpkg -l | awk '/^rc/ { print \$2 }' | xargs sudo dpkg --purge"

# History
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zhist
export HISTSIZE SAVEHIST HISTFILE

# Key bindings
# bindkey -v	# vi key bindings
bindkey -e	# emacs key bindings

# TERM=xterm
bindkey 'OH' beginning-of-line
bindkey '[5C' forward-word
bindkey '[5D' backward-word
bindkey 'OF' end-of-line

# TERM=screen
bindkey '[1~' beginning-of-line
bindkey 'O5C' forward-word
bindkey 'O5D' backward-word
bindkey '[4~' end-of-line

# both
bindkey '[3~' delete-char

# bash style history searching
bindkey '[5~' history-search-backward
bindkey '[6~' history-search-forward

# xterm (the real one)
bindkey '[1;5C' forward-word
bindkey '[1;5D' backward-word
bindkey '[H' beginning-of-line
bindkey '[F' end-of-line

# aterm
bindkey 'Oc' forward-word
bindkey 'Od' backward-word
bindkey '[7~' beginning-of-line
bindkey '[8~' end-of-line
