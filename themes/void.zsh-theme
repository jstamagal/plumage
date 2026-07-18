# ❖ ○ ∘ ·
#   plumage/void — the event horizon
# tagline: green rhombus, orbit decay by directory depth, ∅ on failure
#
# The deeper you cd, the longer the trail of matter spiraling
# toward your cursor. Fail a command and the prompt collapses to
# the empty set. The libc badge is real — check your loader.

if [[ -e /lib/ld-musl-x86_64.so.1 || -e /lib/ld-musl-aarch64.so.1 ]]; then
  typeset -g _plm_void_libc=musl
else
  typeset -g _plm_void_libc=glibc
fi

_plm_void_precmd() {
  local d=${(D)PWD}
  local n=${#${d//[^\/]/}}
  [[ $d == '/' ]] && n=0
  local -a orbs=( '○' '∘' '·' )
  local out='' i
  for (( i = 1; i <= n && i <= 3; i++ )); do
    out+="${orbs[i]}"
  done
  if [[ -n $out ]]; then
    typeset -g _plm_void_pull="%F{72}${out}%f "
  else
    typeset -g _plm_void_pull=''
  fi
}
PLUMAGE_THEME_PRECMD=_plm_void_precmd

PROMPT='%F{72}❖%f %F{252}%n%F{240}·%F{72}${PLUMAGE_BOX}%f %F{240}⟨%F{250}%~%F{240}⟩ ⟨${_plm_void_libc}⟩%f$(plumage_git_seg " %F{240}‹%F{72}" "%F{240}›%f") ${_plm_void_pull}%(?.%F{72}◉%f.%F{203}∅%f) '
