# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

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
HISTSIZE=100
HISTFILESIZE=200

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
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

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

# prompt colors
PROMPT_COLOR_PATH="2;97m"
PROMPT_COLOR_USER="0;36m"
PROMPT_COLOR_INS="2;91m"
PROMPT_COLOR_CMD="0;91m"

if [ "$color_prompt" = yes ]; then
	PS1='\033[$PROMPT_COLOR_PATH[\w]\n'
	EPS='\033[$PROMPT_COLOR_USER\1[\u]'
	INS='\033[$PROMPT_COLOR_INS\1$'
	CMD='\033[$PROMPT_COLOR_CMD\1$'
	reset_readline_prompt_mode_strings () {
		bind "set vi-ins-mode-string \"${EPS@P}${INS@P}\033[00m\2 \""
		bind "set vi-cmd-mode-string \"${EPS@P}${CMD@P}\033[00m\2 \""
	}
	PROMPT_COMMAND=reset_readline_prompt_mode_strings
else
	PS1='[\w]\n'
	EPS='[\u]'
	INS='$'
	CMD='#'
	reset_readline_prompt_mode_strings () {
		bind "set vi-ins-mode-string \"${EPS@P}${INS@P} \""
		bind "set vi-cmd-mode-string \"${EPS@P}${CMD@P} \""
	}
	PROMPT_COMMAND=reset_readline_prompt_mode_strings
fi
unset color_prompt force_color_prompt

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

export EDITOR=vim
export VISUAL=vim
alias ls="ls --color=auto -alh --group-directories-first"

# connect to tmux session when using ssh
if [[ -n "$PS1" ]] && [[ -z "$TMUX" ]] && [[ -n "$SSH_CONNECTION" ]]; then
	tmux has-session -t ssh_tmux 2>/dev/null
	if [ $? != 0 ]; then
		tmux new-session -d -s ssh_tmux
		tmux send-keys -t ssh_tmux "alias exit=\"tmux detach -P\"" ENTER
		tmux send-keys -t ssh_tmux "clear" ENTER
	fi

	tmux attach-session -t ssh_tmux
fi

# disable history
# set +o history
