# plumage/amazon — the meter is running
# tagline: every prompt is billable; the region is wherever you are
#
# The session cost ticks up a few millionths of a dollar per command.
# It is a joke, mostly. The hostname suffix is not — you have read it
# in enough consoles to feel it.

_plm_amzn_precmd() {
  typeset -g _plm_amzn_bill
  printf -v _plm_amzn_bill '$%.6f' $(( ${HISTCMD:-0} * 0.00000217 ))
}
PLUMAGE_THEME_PRECMD=_plm_amzn_precmd

PROMPT='%F{208}λ%f %F{252}%n%F{240}@%F{208}${PLUMAGE_BOX}%F{240}.compute.internal%f %F{240}[%F{250}%~%F{240}]%f %(?.%F{208}.%F{203})⟩%f '
RPROMPT='%F{240}session ≈ %F{178}${_plm_amzn_bill}%f'
