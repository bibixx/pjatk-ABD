alias ls='ls --color=auto'
alias l='ls -lah'
alias ll='ls -l'

fblack=$(tput setaf 0);
fgrey="\e[1;30m";
fblue=$(tput setaf 5);
bblue=$(tput setb 5);
reset=$(tput sgr0);

export PS1="${reset}${bblue}${fblack} \w ${reset}${fblue}\\n${reset}${fgrey}» ${reset}";
