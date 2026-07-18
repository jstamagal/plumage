# λ ⁙ ψ ⁙ μ
#   plumage/chimera — three heads, one animal
# tagline: the prompt glyph rotates between its three natures
#
# One beast stitched from three bodies: a BSD userland, an LLVM
# toolchain, a musl heart. The head that answers your prompt
# changes with every command.

_plm_chi_precmd() {
  local -a h=( 'λ' 'ψ' 'μ' )
  local -a c=( 147 210 79 )
  local i=$(( ${HISTCMD:-0} % 3 + 1 ))
  typeset -g _plm_chi_head="%F{${c[i]}}${h[i]}%f"
}
PLUMAGE_THEME_PRECMD=_plm_chi_precmd

PROMPT='${_plm_chi_head} %F{252}%n%F{240}⁙%F{147}${PLUMAGE_BOX}%f %F{240}⟨%F{250}%~%F{240}⟩%f %(?.${_plm_chi_head}.%F{203}✗%f) '
