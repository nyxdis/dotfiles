# teh profile
. ${EPREFIX}/etc/zsh/zprofile

# keychain
#. ~/.keychain/$(uname -n)-sh
keychain -q ~/.ssh/id_?sa

# produce core dumps
ulimit -c unlimited

# make new files private
umask 022

export PATH="${HOME}/bin:${HOME}/apps/android-sdk/tools:${HOME}/apps/android-sdk/platform-tools:${PATH}"
export GENTOO_AUTHOR_NAME="Christoph Mende"
export GENTOO_AUTHOR_EMAIL="angelos@gentoo.org"

if [ "$TERM" = "xterm" ] ; then
    if [ -z "$COLORTERM" ] ; then
        if [ -z "$XTERM_VERSION" ] ; then
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
            gnome-terminal|Terminal)
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
if [[ ${LANG} != *utf8 ]]; then
	export LANG=en_US.utf8
	export LC_ALL=en_US.utf8
fi

# Completion and Prompt
autoload -U compinit
compinit
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate
export PROMPT="%. %# "

# colors
autoload colors; colors

#eval "`dircolors -b /etc/DIR_COLORS`"

zstyle ':completion:*' list-colors ''
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# Completion Cache
zstyle ':completion::complete:*' use-cache 1

## Options
# Changing Directories
setopt AUTO_CD PUSHD_TO_HOME
# History
setopt APPEND_HISTORY HIST_EXPIRE_DUPS_FIRST HIST_IGNORE_DUPS HIST_FCNTL_LOCK
setopt HIST_REDUCE_BLANKS SHARE_HISTORY
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
alias cvsmaster='ssh -4MNf cvs.gentoo.org'
alias diff='diff -u'
alias grep='egrep --color=auto'
alias leak='valgrind --leak-check=full --show-reachable=yes'
alias ls='ls -F --color=auto'
alias rec='ffmpeg -f video4linux2 -i /dev/video0 tmp.mpeg'
alias rtorrent='screen -S rtorrent rtorrent'
alias sqlite3='sqlite3 -column -header'
alias mv='mv -i'
alias cdrecord='cdrecord -v -eject'
alias pcheck='pcheck -r portdir -a amd64'

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
