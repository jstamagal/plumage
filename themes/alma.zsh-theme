# ⟡ ────────────────────────────── ⟡
#   plumage/alma — carried on
# ⟡ ────────────────────────────── ⟡
# tagline: teal and gold; falls down, gets back up, tells you so
#
# When a command fails and the next one lands, the prompt quietly
# notes the recovery. Community distros know something about that.

_plm_alma_precmd() {
  if (( PLUMAGE_EXIT != 0 )); then
    typeset -g _plm_alma_fell=1
    typeset -g _plm_alma_mark=''
  elif (( ${_plm_alma_fell:-0} )); then
    typeset -g _plm_alma_fell=0
    typeset -g _plm_alma_mark=' %F{179}↻ risen%f'
  else
    typeset -g _plm_alma_mark=''
  fi
}
PLUMAGE_THEME_PRECMD=_plm_alma_precmd

PROMPT='%F{37}⟡%f %F{74}alma%f %F{223}%n%F{240}·%F{80}${PLUMAGE_BOX}%f %F{240}(%F{250}%~%F{240})%f${_plm_alma_mark}
%(?.%F{37}.%F{203})∴%f '
