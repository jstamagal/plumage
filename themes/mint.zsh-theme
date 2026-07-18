# ╭─❧
#   plumage/mint — says it in words
# ╰─
# tagline: soft green, rounded corners, errors explained in English
#
# The friendly one. When a command fails, the prompt tells you what
# the number means instead of assuming you memorized sysexits.h
# in 2003. (You did. It doesn't matter.)

typeset -gA _plm_mint_why=(
  1   'general error'
  2   'usage error'
  126 'found but not executable'
  127 'command not found'
  128 'bad exit argument'
  130 'interrupted (^C)'
  137 'killed (SIGKILL)'
  139 'segmentation fault'
  141 'broken pipe'
  143 'terminated'
)

_plm_mint_precmd() {
  local e=$PLUMAGE_EXIT
  if (( e == 0 )); then
    typeset -g _plm_mint_note=''
    return
  fi
  local why=${_plm_mint_why[$e]:-}
  [[ -z $why ]] && (( e > 128 && e < 165 )) && why="signal $(( e - 128 ))"
  typeset -g _plm_mint_note=" %F{203}✗ ${e}${why:+ %F{240}· %F{250}${why}}%f"
}
PLUMAGE_THEME_PRECMD=_plm_mint_precmd

PROMPT='%F{77}╭─❧%f %F{252}%n%F{240}·%F{77}${PLUMAGE_BOX}%f %F{240}(%F{250}%~%F{240})%f$(plumage_git_seg " %F{240}‹%F{77}" "%F{240}›%f")${_plm_mint_note}
%F{77}╰─»%f '
