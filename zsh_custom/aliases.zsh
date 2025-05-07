alias mv='mv -i'
alias rm='rm -i'
alias cp='cp -i'
alias autopurge="dpkg -l | egrep -q ^rc && dpkg -l | awk '/^rc/ { print \$2 }' | xargs sudo dpkg --purge"
