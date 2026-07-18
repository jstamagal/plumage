# ▲ ⟋⟍⟋
#   plumage/rocky — the ridgeline
# tagline: your path drawn as terrain, green and load-bearing
#
# Directory separators become slope. Deep trees read like a
# traverse. Built after the last mountain got bought — this one
# is community bedrock.

_plm_rocky_precmd() {
  local -a segs=( ${(s:/:)${(D)PWD}} )
  (( $#segs )) || segs=( '/' )
  local out='' i
  for (( i = 1; i <= $#segs; i++ )); do
    out+="%F{114}${segs[i]}%f"
    if (( i < $#segs )); then
      (( i % 2 )) && out+='%F{240}⟋%f' || out+='%F{240}⟍%f'
    fi
  done
  typeset -g _plm_rocky_path=$out
}
PLUMAGE_THEME_PRECMD=_plm_rocky_precmd

PROMPT='%F{114}▲%f %F{252}%n%F{240}·%F{114}${PLUMAGE_BOX}%f ${_plm_rocky_path} %(?.%F{114}.%F{203})⟰%f '
