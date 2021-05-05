# 
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [[ -z "$just_started" && "$PWD" == *Desktop* ]]; then
	cd "$HOME"
fi

if [[ -z "$just_started" && "$PWD" == *wsl-terminal-tabbed* ]]; then
  cd "$HOME"
fi

[[ -f ~/.config/less ]] && . ~/.config/less


# including this ensures that new gnome-terminal tabs keep the parent `pwd` !
[ -e /etc/profile.d/vte.sh ] && source /etc/profile.d/vte.sh
[ -f ~/.config/welcome ] &&	source ~/.config/welcome
[ -f ~/.bash_aliases ] && source ~/.bash_aliases

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
	
################## SETTING SOME ENVIROMENT VARIABLES #############

export just_started=false
export LESS="--RAW-CONTROL-CHARS"
#export MANPAGER='less -s -M +Gg'
export MANPAGER="/bin/sh -c \"col -b | vim --not-a-term -c 'set ft=man ts=8 nomod nolist nonu noma' -\""
export XZ_OPT="-9"
export VIRSH_DEFAULT_CONNECT_URI="qemu:///system"
export XDG_CONFIG_HOME="$HOME/.config"

# Wine variables
### export WINEDLLOVERRIDES="winemenubuilder.exe=d" ### Disable menubuilder for all prefixes
export WINEDEBUG=-all
export WINEARCH="win32"

[[ -f ~/.config/less ]] && . ~/.config/less


#PS1='[\u@\h \W]\$ '
PS1='\[\e]0;\u@\h: \w\a\]\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$ '
export PS1

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

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
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

############## USE COLORS ############################

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

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
#    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\$ '
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\W\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi


# Turn on 256 color support...
if [ "x$TERM" = "xxterm" ]
then
    export TERM="xterm-256color"
fi

###  COLORS: BEGIN
alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ls='ls --color=auto'
alias ip='ip -c'
            # colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'


### CHANGE OUTPUT OF SOME COMMANDS: BEGIN
  # (see also aliases for color above, cant be two aliases!)
alias lsblk='lsblk -o NAME,FSTYPE,MOUNTPOINT,LABEL,PARTLABEL,MODEL,UUID' ## more detailed output
alias dig='dig +nocmd +multiline +noall +answer' ## use drill instead!!!
alias mountfs='mount | grep -vE "fusectl|gvfsd-fuse|hugetlbfs|cgroup|autofs|sysfs|devtmpfs|efivarfs|securityfs|devpts|pstore|bpf|mqueue|debugfs|binfmt_misc|configfs|proc|/run|/dev/shm"'


################ ADD SHORTCUTS ######################
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'


################ ADD SOME FINCTIONALITY ################
alias extip='curl -4 http://icanhazip.com'
alias psgrep='ps aux | grep -v "grep" | grep'
alias checkfat='dosfsck -w -r -l -a -v -t'
alias genpass='</dev/urandom tr -dc 'a-zA-Z0-9' | fold -w 12 | head -n 1'



# FOR GUI ONLY
# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
## alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

##export MC_XDG_OPEN=~/.bin/nohup-open


#export QT_QPA_PLATFORMTHEME=“qt5ct”


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


################ USEFUL FUNCTIONS ######################

UtfToAscii() {
	if [ "$#" -eq 2 ] && [ -f "$1" ] && [ -w "$2"]; then
		local currformat=`file -b mozilla.cfg | cut -f 1 -d " "`
		if [ ${currformat,,} == "ascii" ]; then
			iconv -f utf8 -t ascii $1 $2
				else
				echo "The file in ascii already, then nothing to do"
				fi
			echo "Check parameters; there must be two files, and second must be writable"
	fi
}

rl() {
	source ~/.bashrc && echo -e "~/.bashrc was reloaded\n" || echo -e "~/.bashrc have error[s]"
#	test -f ~/.profile && source ~/.profile && echo -e "~/.profile was reloaded\n"
}

artistlist() {
	find "$PWD/" -maxdepth 2 -mindepth 2 -type d -printf '%f\n'
}

sudo() {
	if [ "$1" == "nano" ]; then
		### My everyday mistake; i shoud use "sudoedit" instead "sudo nano"
		shift
		sudoedit "$@"
	elif [ "$1" == "mvroot" ]; then
		shift
		sudo mv "$@"
		sudo chown -R root:root "${@: -1}"
	else
		command sudo "$@"
	fi
}

mvroot() {
	if [ "$1" == "sudo" ]; then
		shift
	fi
	sudo mv "$@"
	sudo chown -R root:root "${0: -1}"
}


###[[ "$PATH" != *"Windows"* ]] how to dot it???
setbg() {
	echo $1
	[ -r "$1" ] &&  (ln -sf "`readlink -e $1`" ~/.local/share/wallpaper.jpg; feh --bg-fill ~/.local/share/wallpaper.jpg) || \
		echo "What picture?"
}

catdir() {
	for file in `ls $1/*${2}`; do 
       if [ -f "$file" ]; then
          echo "_____________________________"; echo  "$file"; cat $file;
	   fi
    done
}




# SSH AGENT
## if [ -z "$SSH_AUTH_SOCK" ] ; then
## eval `ssh-agent -s` >/dev/null
#  ssh-add - < ~/.ssh/my_key
## fi


