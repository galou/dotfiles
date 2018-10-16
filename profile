# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
	echo $PATH | grep $HOME/.local/bin > /dev/null
	if [ $? = 1 ]; then
		PATH="$HOME/.local/bin:$PATH"
	fi
fi

# if running bash
# if [ -n "$BASH_VERSION" ]; then
#     # include .bashrc if it exists
#     if [ -f "$HOME/.bashrc" ]; then
# 	. "$HOME/.bashrc"
#     fi
# fi

# 256-color terminal
if [ -n "$DISPLAY" -a "$TERM" = "xterm" ]; then
	export TERM=xterm-256color
fi

#function jvim
#{
#       	file="$(AUTOJUMP_DATA_DIR=~/.autojump.vim/global autojump $@)"
#	if [ -n "$file" ]; then 
#		vim "$file";
#       	fi
#}

# The ${VAR+foo} construct expands to the empty string if VAR is unset or to
# foo if VAR is set to anything (including the empty string).
export PKG_CONFIG_PATH=${PKG_CONFIG_PATH}${PKG_CONFIG_PATH+:}/usr/local/lib64/pkgconfig
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}${LD_LIBRARY_PATH+:}/usr/local/lib64

# Eclipse home, for Eclipse to see eclipse.ini
export ECLIPSE_HOME=$HOME/.config/eclipse

# Since IPython 2.0, the config directory is ~/.ipython, override this
export IPYTHONDIR=$HOME/.config/ipython
export JUPYTER_CONFIG_DIR=$HOME/.config/jupyter

# Matplotlib configuration (instead of ~/.matploblib).
export MPLCONFIGDIR=$HOME/.config/matplotlib

# ROS configuration
export ROS_WORKSPACE=$HOME/ros_kinetic_ws
export ROS_LANG_DISABLE=genlisp

# Add completion for gr
if command -v gr >/dev/null 2>&1; then
    source <(gr completion)
fi

get_ip()
{
	ip=$(ifconfig eno1 | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1')
	if [ -z "$ip" ]; then
		ip=$(ifconfig wlp3s0 | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1')
	fi
	if [ -z "$ip" ]; then
		ip='127.0.0.1'
	fi
	echo $ip
}

get_ip_wlp3s0()
{
    ip=$(ifconfig wlp3s0 | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1')
    if [ -z "$ip" ]; then
	ip='127.0.0.1'
    fi
    echo $ip
}

ros_master_local()
{
    export ROS_MASTER_URI="http://localhost:11311"
    export ROS_IP=$(get_ip)
    #export ROS_HOSTNAME="pcgael"
}

ros_master_syrotek()
{
    export ROS_MASTER_URI="http://syrotek.felk.cvut.cz:11311"
    #export ROS_MASTER_URI="http://147.32.84.212:11311"
    export ROS_IP=$(get_ip)
    #export ROS_HOSTNAME="pcgael"
}

ros_master_morbot()
{
    export ROS_MASTER_URI="http://169.254.0.2:11311"
    export ROS_IP=$(get_ip_wlp3s0)
    #export ROS_HOSTNAME="pcgael"
}

ros_master_host_wifi()
{
    export ROS_MASTER_URI="http://$1:11311"
    export ROS_IP=$(get_ip_wlp3s0)
}

ros_master_emili_wifi()
{
    export ROS_MASTER_URI="http://172.16.180.139:11311"
    export ROS_IP=$(get_ip_wlp3s0)
}

# cf. http://wiki.ros.org/rosconsole
ros_rosconsole_format_default()
{
    export ROSCONSOLE_FORMAT='[${severity}] [${time}]: ${message}'
}

ros_rosconsole_format_node_message()
{
    export ROSCONSOLE_FORMAT='[${severity}] [${node}]: ${message}'
}

conda_activate()
{
    export PATH=/home/gael/.local/lib/conda/bin:$PATH
}

fcd()
{
    cd $(dirname $1)
}

# training for ros industrial
#. ~/industrial_training/training/.training_units.zsh

# Delete shortcut created by Office Setup.
rm -f "/home/gael/.local/share/applications/wine/Programs/Microsoft Office/Microsoft Office 2010 Tools/Digital Certificate for VBA Projects.desktop"

export WINEARCH=win32
