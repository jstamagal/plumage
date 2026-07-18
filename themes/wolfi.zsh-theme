# ω ∿∿
#   plumage/wolfi — the smallest octopus
# tagline: lavender, ⟨un⟩branded, one tentacle per background job
#
# Named for the world's tiniest octopus, built for containers that
# barely exist. Suspended and background jobs show up as arms —
# it is holding those for you.

_plm_wolfi_precmd() {
  local n=${#jobstates} t=''
  repeat $n t+='∿'
  typeset -g _plm_wolfi_arms=''
  (( n )) && _plm_wolfi_arms="%F{141}${t}%f "
}
PLUMAGE_THEME_PRECMD=_plm_wolfi_precmd

PROMPT='%F{141}ω%f %F{252}%n%F{240}·%F{183}⟨un⟩%F{141}${PLUMAGE_BOX}%f %F{240}[%F{250}%~%F{240}]%f ${_plm_wolfi_arms}%(?.%F{141}.%F{203})»%f '
