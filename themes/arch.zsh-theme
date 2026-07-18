# ·╼━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╾·
#   plumage/arch — the pellet line
# ·╼━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╾·
# tagline: cyan and tidy, but something keeps eating your history
#
# The chomper advances one pellet per command. Fail a command and
# a ghost slips in right behind you. You know which one this box is.

_plm_arch_precmd() {
  local i=$(( ${HISTCMD:-0} % 4 ))
  local ahead='' behind=''
  repeat $(( 3 - i )) ahead+='·'
  repeat $i behind+=' '
  if (( PLUMAGE_EXIT != 0 )); then
    if (( i > 0 )); then
      behind=''
      repeat $(( i - 1 )) behind+=' '
      behind+='%F{203}ᗣ%f'
    else
      behind='%F{203}ᗣ%f'
    fi
  fi
  typeset -g _plm_arch_pac="${behind}%F{220}ᗧ%F{245}${ahead}%f"
}
PLUMAGE_THEME_PRECMD=_plm_arch_precmd

PROMPT='%F{45}╼%f ${_plm_arch_pac} %F{45}%n%F{240}·%F{51}${PLUMAGE_BOX}%f %F{240}(%F{252}%~%F{240})%f$(plumage_git_seg " %F{240}‹%F{116}" "%F{240}›%f")
%F{45}╘%(?.%F{45}.%F{203})»%f '
