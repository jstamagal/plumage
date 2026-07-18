# ∞ ─────────────────────────── ∞
#   plumage/fedora — fresh build
# tagline: blue infinity, and your path ships as a package
#
# The working directory is rendered like something just out of the
# build system, release-tagged for this very box. First. Always
# first.

_plm_fed_precmd() {
  typeset -g _plm_fed_tag=".fc${PLUMAGE_OS_VERSION%%.*}.${CPUTYPE:-x86_64}"
}
PLUMAGE_THEME_PRECMD=_plm_fed_precmd

PROMPT='%F{33}∞%f %F{252}%n%F{240}·%F{33}${PLUMAGE_BOX}%f %F{240}[%F{110}%~%F{240}]${_plm_fed_tag}%f$(plumage_git_seg " %F{240}‹%F{110}" "%F{240}›%f") %(?.%F{33}.%F{203})➔%f '
