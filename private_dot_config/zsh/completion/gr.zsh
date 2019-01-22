###-begin-gr-completion-###
### credits to npm, this file is coming directly from isaacs/npm repo
#
# Just testing for now. (trying to learn this cool stuff)
#
# npm command completion script
#
# Installation: gr completion >> ~/.bashrc  (or ~/.zshrc)
#

COMP_WORDBREAKS=${COMP_WORDBREAKS/=/}
COMP_WORDBREAKS=${COMP_WORDBREAKS/@/}
export COMP_WORDBREAKS

if complete &>/dev/null; then
  _gr_completion () {
    local si="$IFS"
    IFS=$'\n' COMPREPLY=($(COMP_CWORD="$COMP_CWORD" \
                           COMP_LINE="$COMP_LINE" \
                           COMP_POINT="$COMP_POINT" \
                           gr completion -- "${COMP_WORDS[@]}" \
                           2>/dev/null)) || return $?
    IFS="$si"
  }
  complete -F _gr_completion -o default gr
elif compctl &>/dev/null; then
  _gr_completion () {
    local cword line point words si
    read -Ac words
    read -cn cword
    let cword-=1
    read -l line
    read -ln point
    si="$IFS"
    IFS=$'\n' reply=($(COMP_CWORD="${cword}" \
                       COMP_LINE="${(q)line}" \
                       COMP_POINT="${point}" \
                       gr completion -- "${(qq)words[@]}" \
                       2>/dev/null)) || return $?
    IFS="$si"
  }
  compctl -K _gr_completion gr
fi
###-end-gr-completion-###

