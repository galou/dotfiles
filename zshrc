# If not running interactively, don't do anything
if [[ ! -o interactive ]]; then
  return
fi

# Uncomment the following line and the first line to start profiling.
# zprof

# Aliases
if [ -f ~/.shell_aliases ]; then
    . ~/.shell_aliases
fi
if [ -f ~/.zsh_aliases ]; then
    . ~/.zsh_aliases
fi

# Profile
if [ -f ~/.profile ]; then
	. ~/.profile
fi

# Deactive ctrl-s sending xoff
# so that it can be used for something else
stty ixany
stty ixoff
stty -ixon
# Deactive showing ^C when ctrl-c
stty -echoctl


# antigen configuration
ADOTDIR=$HOME/.config/antigen
source $ADOTDIR/antigen/antigen.zsh
antigen use oh-my-zsh
antigen bundle common-aliases
# Some useful git aliases
antigen bundle git
antigen bundle pip
# Proposes a package for a missing command
antigen bundle command-not-found
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
# support approximate matching – pressing Ctrl-F during search will allow 1 or 2 errors in what is typed in
# http://psprint.github.io/Zsh-Navigation-Tools-approximate-matching/
antigen bundle zsh-navigation-tools
antigen theme agnoster
antigen apply
# tweak to agnoster theme
DEFAULT_USER=gael
prompt_dir() {
  prompt_segment blue black '%1~'
}

# Tweak to terminal title set by oh-my-zsh
ZSH_THEME_TERM_TAB_TITLE_IDLE="%20<..<%~%<<" #20 char left truncated PWD, seems to have no effect with gnome-terminal
ZSH_THEME_TERM_TITLE_IDLE="%20<..<%~%<<"

# Terminal title on directory change
# cf. http://www.tldp.org/HOWTO/text/Xterm-Title
# Deactivated because set by oh-my-zsh
# case $TERM in
# 	xterm*)
# 		precmd() {print -Pn "\e]0;%20<..<%~\a"}
# 		;;
# esac

# Old PS1, now set by agnoster theme
#export PS1='%B%F{green}%n@%m%f %F{blue}%1~ %#%f%b '

# antigen sets 'alias gr=git remote', gr is also a program to manage several git repos.
unalias gr

# History management
HISTFILE=~/.bash_history
HISTSIZE=1000
SAVEHIST=2000
# save to history immediately but doesn't read history from other shells
setopt inc_appendhistory
setopt hist_ignore_dups
setopt hist_save_no_dups

# Vim key bindings
bindkey -v

# Completion configuration.
# Case-insensitive completion.
# Highlight the common part and the next character of completions.
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)(?)*==02=01}:${(s.:.)LS_COLORS}")'

# Add custom directory for completion.
fpath+=$HOME/.config/zsh/completion

# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored
zstyle ':completion:*' ignore-parents parent pwd
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle :compinstall filename '/home/gael/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

bindkey "^R" history-incremental-search-backward
bindkey '^P' up-history
bindkey '^N' down-history
# Search with command starting with the same letters
autoload up-line-or-beginning-search # load hook
autoload down-line-or-beginning-search
zle -N up-line-or-beginning-search # activate hook
zle -N down-line-or-beginning-search
bindkey "${key[Up]}" up-line-or-beginning-search # add keybinding to hook
bindkey "${key[Down]}" down-line-or-beginning-search
bindkey '[1;5D' backward-word # Ctrl-Left
bindkey '[1;5C' forward-word # Ctrl-Right

# Alt + . inserts the last parameter from the last command
bindkey "." insert-last-word

# 'ctrl-x r' will complete the 12 last modified (mtime) files/directories
zle -C newest-files complete-word _generic
bindkey '^Xr' newest-files
zstyle ':completion:newest-files:*' completer _files
zstyle ':completion:newest-files:*' file-patterns '*~.*(omN[1,12])'
zstyle ':completion:newest-files:*' menu select yes
zstyle ':completion:newest-files:*' sort false
zstyle ':completion:newest-files:*' matcher-list 'b:=*' # important

# 'ctrl-x *' will expand the current word.
bindkey '^X*' expand-word

# Case-insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Key bindings for fasd completion
bindkey '^X^F' fasd-complete-f  # C-x C-f to do fasd-complete-f (only files)
bindkey '^X^D' fasd-complete-d  # C-x C-d to do fasd-complete-d (only dirs)

# Show vim mode (http://dougblack.io/words/zsh-vi-mode.html)
# TODO: solve incompatiblity with Ctrl-Up binding
#function zle-line-init zle-keymap-select {
#	VIM_PROMPT="%{$fg_bold[yellow]%} [% NORMAL]%  %{$reset_color%}"
#	RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/} $EPS1"
#	zle reset-prompt
#}
#
#zle -N zle-line-init
#zle -N zle-keymap-select
#export KEYTIMEOUT=1

# fasd initialization
fasd_cache="$HOME/.cache/fasd-init-zsh"
if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
	fasd --init posix-alias zsh-hook zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install >| "$fasd_cache"
fi
source "$fasd_cache"
unset fasd_cache

fasd_cd() {
  if [ $# -le 1 ]; then
    fasd "$@"
  else
    local _fasd_ret="$(fasd -e 'printf %s' "$@")"
    [ -z "$_fasd_ret" ] && return
    [ -d "$_fasd_ret" ] && cd "$_fasd_ret" && printf "$_fasd_ret\\n"
  fi
}


# Do not expand glob patterns, propose a list of matches instead.
setopt globcomplete
setopt interactivecomments # pound sign in interactive prompt as a comment

# Use extendedglob (for example ^CMakeLists.txt for all but this file)
setopt extendedglob

# Completion for gr (Generated with `gr completion >> ...`
if [ -e $HOME/.config/zsh/completion/gr.zsh ]; then
  source $HOME/.config/zsh/completion/gr.zsh
fi

# ROS setup
ros_activate() {
  if [[ $HOST = "pcgael3" ]]; then
    export ROS_WORKSPACE=$HOME/ros_melodic_ws
  elif [[ $HOST = "pcgael2" ]]; then
    export ROS_WORKSPACE=$HOME/ros_kinetic_ws
  elif [[ $HOST = "pcgael" ]]; then
    export ROS_WORKSPACE=$HOME/ros_indigo_ws
  fi

  if [ -e $ROS_WORKSPACE/devel/setup.zsh ]; then
    source $ROS_WORKSPACE/devel/setup.zsh
  fi
  # Add /usr/lib/x86_64-linux-gnu for Gazebo urdf parser to work
  # export LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu${LD_LIBRARY_PATH+:}$LD_LIBRARY_PATH

  # slaunch as alias doesn't help because completion doesn't work (zsh 5.1.1)
  alias slaunch='roslaunch safelog_launch'
}

# Activate ROS if /tmp/activate_ros exists.
if [ -e /tmp/activate_ros ]; then
  ros_activate
fi

