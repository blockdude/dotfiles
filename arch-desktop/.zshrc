# environment variables
export EDITOR=vim
export VISUAL=vim
export LC_ALL="C"
export PATH=$PATH:/home/mary/.local/bin/

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install

# The following lines were added by compinstall
zstyle :compinstall filename '/home/mary/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# aliases
alias restart="shutdown -r now"
alias shutdown="shutdown -P now"
alias halt="shutdown -H now"
alias ls="ls --color=auto -lha --group-directories-first"
alias vi=vim

# change normal mode delay
export KEYTIMEOUT=1

# add show dotfiles on auto complete
_comp_options+=(globdots)

# enable colors
autoload -U colors && colors

# fix zsh bindings
bindkey "^?" backward-delete-char
bindkey "^h" backward-delete-char
bindkey "^[[P" delete-char
bindkey -a "^[[H" beginning-of-line
bindkey -a "^[[4~" end-of-line


# zsh vi custom prompt and indicator
function precmd()
{
	print -P "%F{167}[${PWD/#$HOME/~}]%F{reset}"
}

PS1="%F{178}[%n]%F{125}%#%F{reset} "
function zle-keymap-select()
{
	if [[ $KEYMAP = vicmd ]] then
		PS1="%F{179}[%n]%F{171}%#%F{reset} "
	else
		PS1="%F{178}[%n]%F{125}%#%F{reset} "
	fi
	zle reset-prompt	
}
zle -N zle-keymap-select
zle-line-init()
{
	zle -K viins
}
zle -N zle-line-init
# set color for vi indicator for every prompt
preexec() { PS1="%F{178}[%n]%F{125}%#%F{reset} " }

# redefine clear screen so precmd shows after clearing screen
clear-screen() { echoti clear; precmd; zle redisplay; }
zle -N clear-screen
