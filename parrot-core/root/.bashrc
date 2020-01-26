# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# Text Layouts:
    Default='\e[0m'       	# Reset to default (also reset colors)
    Bold='\e[1m'          	# Bold
    Italic='\e[3m'        	# Italic
    Underline='\e[4m'    	# Underline
    Strikethrough='\e[9m'	# Strikethrough
# Text Colors:
    Black='\e[30m'		# Black
    Red='\e[31m'        	# Red
    Green='\e[32m'		# Green
    Yellow='\e[33m'     	# Yellow
    Blue='\e[34m'       	# Blue
    Purple='\e[35m'       	# Purple
    Cyan='\e[36m'         	# Cyan
    White='\e[37m'        	# White
    Grey='\e[90m'		# Grey
    LRed='\e[91m' 	        # Light red
    LGreen='\e[92m'		# Light green
    LYellow='\e[93m'      	# Light yellow
    LBlue='\e[94m'        	# Light blue
    LPurple='\e[95m'      	# Light purple
    LCyan='\e[96m'        	# Light cyan
    Whiter='\e[97m'       	# More white
# Text Backgrounds:
    On_Black='\e[40m'		# Black
    On_Red='\e[41m'         	# Red
    On_Green='\e[42m'       	# Green
    On_Yellow='\e[43m'      	# Yellow
    On_Blue='\e[44m'        	# Blue
    On_Purple='\e[45m'      	# Purple
    On_Cyan='\e[46m'        	# Cyan
    On_White='\e[47m'       	# White
    On_Grey='\e[100m'       	# Grey
    On_LRed='\e[101m'       	# Light red
    On_LGreen='\e[102m'     	# Light green
    On_LYellow='\e[103m'    	# Light yellow
    On_LBlue='\e[104m'      	# Light blue
    On_LPurple='\e[105m'    	# Light purple
    On_LCyan='\e[106m'      	# Light cyan
    On_Whiter='\e[107m'     	# More white

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

export PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/usr/share/games:/usr/local/sbin:/usr/sbin:/sbin:~/.local/bin:/snap/bin:$PATH

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1="\[$Default\]\[$Red\]\342\224\214\342\224\200\$([[ \$? != 0 ]] && echo \"[\[$Default\]\[$Red\]\342\234\227\[$Default\]\[$Red\]]\342\224\200\")[\$([[ \[$EUID\] == 0 ]] && echo \"\[$Bold\]\[$Red\]root\[$Bold\]\[$Yellow\]@\[$Bold\]\[$LCyan\]\h\" || echo \"\[$Default\]\[$White\]\u\[$Bold\]\[$Yellow\]@\[$Bold\]\[$LCyan\]\h\")\[$Default\]\[$Red\]]\342\224\200[\[$Default\]\[$Green\]\w\[$Default\]\[$Red\]]\n\[$Default\]\[$Red\]\342\224\224\342\224\200\342\224\200\342\225\274 \[$Bold\]\[$Yellow\]\\\$\[$Default\]"
else
    PS1='┌──[\u@\h]─[\w]\n└──╼ \$ '
fi

# Set 'man' colors
if [ "$color_prompt" = yes ]; then
	man() {
	env \
	LESS_TERMCAP_mb=$'\e[01;31m' \
	LESS_TERMCAP_md=$'\e[01;31m' \
	LESS_TERMCAP_me=$'\e[0m' \
	LESS_TERMCAP_se=$'\e[0m' \
	LESS_TERMCAP_so=$'\e[01;44;33m' \
	LESS_TERMCAP_ue=$'\e[0m' \
	LESS_TERMCAP_us=$'\e[01;32m' \
	man "$@"
	}
fi

unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[$Default\]\[$Red\]\342\224\214\342\224\200\$([[ \$? != 0 ]] && echo \"[\[$Default\]\[$Red\]\342\234\227\[$Default\]\[$Red\]]\342\224\200\")[\$([[ \[$EUID\] == 0 ]] && echo \"\[$Bold\]\[$Red\]root\[$Bold\]\[$Yellow\]@\[$Bold\]\[$LCyan\]\h\" || echo \"\[$Default\]\[$White\]\u\[$Bold\]\[$Yellow\]@\[$Bold\]\[$LCyan\]\h\")\[$Default\]\[$Red\]]\342\224\200[\[$Default\]\[$Green\]\w\[$Default\]\[$Red\]]\n\[$Default\]\[$Red\]\342\224\224\342\224\200\342\224\200\342\225\274 \[$Bold\]\[$Yellow\]\\\$\[$Default\]"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -lh'
alias la='ls -lha'
alias l='ls -CF'
alias em='emacs -nw'
alias dd='dd status=progress'
alias _='sudo'
alias _i='sudo -i'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
