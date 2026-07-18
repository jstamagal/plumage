# ● ● ●
#   plumage/ubuntu — circle of friends
# tagline: three warm dots that remember your last three exits
#
# The trio up front is a memory: one dot per recent command,
# warm and filled when it worked, hollow and red when it didn't.
# Humanity to computers, extended to exit codes.

_plm_ubu_precmd() {
  local -a c=( 208 172 133 )
  local out='' i n=${#PLUMAGE_EXITS}
  for i in 1 2 3; do
    if (( i <= n )); then
      if (( ${PLUMAGE_EXITS[i]} == 0 )); then
        out+="%F{${c[i]}}●%f"
      else
        out+='%F{196}○%f'
      fi
    else
      out+='%F{240}·%f'
    fi
  done
  typeset -g _plm_ubu_ring=$out
}
PLUMAGE_THEME_PRECMD=_plm_ubu_precmd

PROMPT='${_plm_ubu_ring} %F{252}%n%F{208}@%F{214}${PLUMAGE_BOX}%f %F{240}(%F{250}%~%F{240})%f$(plumage_git_seg " %F{240}‹%F{214}" "%F{240}›%f") %(?.%F{208}.%F{203})»%f '
