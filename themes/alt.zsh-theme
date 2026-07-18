# ▁▂▃▄▅ ● ▅▄▃▂▁
#   plumage/alt — the hill
# tagline: a boulder climbs while your commands succeed; you know the rest
#
# ALT builds from Sisyphus. So: every clean exit rolls the boulder one
# step up the hill. It never stays at the top. One must imagine the
# prompt happy.

_plm_alt_precmd() {
  local hill='▁▂▃▄▅'
  local pos=$(( PLUMAGE_STREAK % 5 ))
  typeset -g _plm_alt_hill="%F{240}${hill[1,pos]}%F{215}●%F{240}${hill[pos+2,5]}%f"
}
PLUMAGE_THEME_PRECMD=_plm_alt_precmd

PROMPT='${_plm_alt_hill} %F{252}%n%F{240}·%F{215}${PLUMAGE_BOX}%f %F{240}(%F{250}%~%F{240})%f %(?.%F{215}.%F{203})▷%f '
