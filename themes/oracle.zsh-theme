# ▌ORCL▐
#   plumage/oracle — per-seat licensing
# tagline: red badge, service-request numbering, the audit never sleeps
#
# Every prompt is a service request; the counter is your history
# number, zero-padded the way enterprise likes it. The right side
# reports audit findings on your last command.

_plm_ora_precmd() {
  typeset -g _plm_ora_sr
  printf -v _plm_ora_sr 'SR#%06d' $(( ${HISTCMD:-0} ))
}
PLUMAGE_THEME_PRECMD=_plm_ora_precmd

PROMPT='%K{160}%F{231} ORCL %k%f %F{252}%n%F{240}·%F{167}${PLUMAGE_BOX}%f %F{240}[%F{250}%~%F{240}]%f %F{240}${_plm_ora_sr}%f %(?.%F{160}.%F{203})▸%f '
RPROMPT='%(?.%F{240}audit⁚%F{70}pass%f.%F{240}audit⁚%F{196}FAIL %?%f)'
