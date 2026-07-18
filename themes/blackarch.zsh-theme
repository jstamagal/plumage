# ▚▞▚▞▚▞▚▞▚▞▚▞▚▞▚▞▚▞▚▞▚▞▚▞▚▞▚▞▚▞▚
#   plumage/blackarch — signal noise
# ▞▚▞▚▞▚▞▚▞▚▞▚▞▚▞▚▞▚▞▚▞▚▞▚▞▚▞▚▞▚▞
# tagline: arch gone over to the red side, picking up static
#
# The interference glyph re-tunes itself on every command.
# One inverted tab, everything else black and red.

_plm_ba_precmd() {
  local -a g=( ▚ ▞ ▖ ▗ ▘ ▝ )
  typeset -g _plm_ba_st=${g[$(( ${HISTCMD:-0} % 6 + 1 ))]}
}
PLUMAGE_THEME_PRECMD=_plm_ba_precmd

PROMPT='%K{124}%F{231} ba %k%f %F{160}${_plm_ba_st}%f %F{252}%n%F{240}⁚%F{160}${PLUMAGE_BOX}%f %F{240}[%F{250}%~%F{240}]%f%(1j. %F{240}⟨%F{160}%j&%F{240}⟩%f.)
%(?.%F{160}.%F{88})╳%f '
RPROMPT='%(?..%F{240}⟨%F{160}%?%F{240}⟩%f)'
