# ⌾ ~›
#   plumage/opensuse — camouflage
# tagline: calm green until something goes wrong, then the whole skin turns
#
# Chameleon rules: the entire accent — eye, name, tongue — shifts
# from settled green to alarm orange with the last exit status.
# It is not changing color to hide. It is changing color at you.

_plm_suse_precmd() {
  if (( PLUMAGE_EXIT == 0 )); then
    typeset -g _plm_suse_c=70 _plm_suse_eye='⌾'
  else
    typeset -g _plm_suse_c=208 _plm_suse_eye='◉'
  fi
}
PLUMAGE_THEME_PRECMD=_plm_suse_precmd

PROMPT='%F{${_plm_suse_c}}${_plm_suse_eye}%f %F{252}%n%F{240}·%F{${_plm_suse_c}}${PLUMAGE_BOX}%f %F{240}[%F{250}%~%F{240}]%f %F{${_plm_suse_c}}~›%f '
