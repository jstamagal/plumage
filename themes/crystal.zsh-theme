# ✦ ✧ ◆ ◇ ❖ ✵
#   plumage/crystal — facets
# tagline: every directory refracts its own gem, same one every time
#
# The gem is a hash of your working directory: deterministic,
# personal to each path. cd around and watch the light change.

_plm_cry_precmd() {
  local -a g=( '✦' '✧' '◆' '◇' '❖' '✵' )
  local -a c=( 117 183 219 156 228 141 )
  local h=0 ch
  for ch in ${(s::)PWD}; do (( h = (h * 31 + #ch) % 6 )); done
  typeset -g _plm_cry_gem="%F{${c[h+1]}}${g[h+1]}%f"
}
PLUMAGE_THEME_PRECMD=_plm_cry_precmd

PROMPT='${_plm_cry_gem} %F{183}%n%F{240}·%F{141}${PLUMAGE_BOX}%f %F{240}⟨%F{250}%~%F{240}⟩%f %(?.${_plm_cry_gem}.%F{203}✗%f) '
