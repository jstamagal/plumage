# plumage/core — shared machinery for every theme.
# Real shell state only: exit codes, streaks, durations, jobs, git.

zmodload zsh/datetime 2>/dev/null

typeset -g  PLUMAGE_EXIT=0        # exit code of the last real command
typeset -g  PLUMAGE_RAN=0         # 1 between preexec and the next precmd
typeset -g  PLUMAGE_TOOK=''       # how long the last command took, human form
typeset -gF PLUMAGE_TOOK_S=0      # same, raw seconds
typeset -g  PLUMAGE_STREAK=0      # consecutive successful commands
typeset -ga PLUMAGE_EXITS         # the last three exit codes, oldest first
typeset -gF _plumage_t0=0

# ── distro facts ────────────────────────────────────────────────────
plumage_read_os() {
  typeset -g PLUMAGE_BOX="${CONTAINER_ID:-${HOST%%.*}}"
  typeset -g PLUMAGE_OS_ID='' PLUMAGE_OS_LIKE='' PLUMAGE_OS_VERSION=''
  typeset -g PLUMAGE_OS_CODENAME='' PLUMAGE_OS_PRETTY=''
  local f k v
  for f in /etc/os-release /usr/lib/os-release; do
    [[ -r $f ]] || continue
    while IFS='=' read -r k v; do
      v=${v//\"/}
      case $k in
        ID)               PLUMAGE_OS_ID=${v:l} ;;
        ID_LIKE)          PLUMAGE_OS_LIKE=${v:l} ;;
        VERSION_ID)       PLUMAGE_OS_VERSION=$v ;;
        VERSION_CODENAME) PLUMAGE_OS_CODENAME=$v ;;
        PRETTY_NAME)      PLUMAGE_OS_PRETTY=$v ;;
      esac
    done < $f
    break
  done
}

# ── git: branch name plus a star when dirty; opt out with PLUMAGE_GIT=0
plumage_git() {
  [[ ${PLUMAGE_GIT:-1} == 0 ]] && return
  (( $+commands[git] )) || return
  local ref
  ref=$(command git symbolic-ref --short -q HEAD 2>/dev/null) ||
    ref=$(command git rev-parse --short HEAD 2>/dev/null) || return
  local dirty=''
  [[ -n $(command git status --porcelain -uno --no-optional-locks 2>/dev/null | head -1) ]] && dirty='*'
  print -rn -- "${ref}${dirty}"
}

# wrap the git ref in theme-supplied dressing, or print nothing at all
plumage_git_seg() {
  local r=$(plumage_git)
  [[ -n $r ]] && print -rn -- "${1}${r}${2}"
}

# ── hooks ───────────────────────────────────────────────────────────
_plumage_preexec() {
  _plumage_t0=$EPOCHREALTIME
  PLUMAGE_RAN=1
}

# runs FIRST in the precmd chain, so it sees the true exit status
_plumage_capture() {
  local ec=$?
  (( PLUMAGE_RAN )) || return 0
  PLUMAGE_EXIT=$ec
  PLUMAGE_RAN=0

  PLUMAGE_TOOK_S=$(( EPOCHREALTIME - _plumage_t0 ))
  if (( PLUMAGE_TOOK_S >= 60 )); then
    PLUMAGE_TOOK="$(( int(PLUMAGE_TOOK_S) / 60 ))m$(( int(PLUMAGE_TOOK_S) % 60 ))s"
  else
    PLUMAGE_TOOK="$(printf '%.1fs' $PLUMAGE_TOOK_S)"
  fi

  if (( ec == 0 )); then
    (( PLUMAGE_STREAK++ ))
  else
    PLUMAGE_STREAK=0
  fi

  PLUMAGE_EXITS+=( $ec )
  (( ${#PLUMAGE_EXITS} > 3 )) && PLUMAGE_EXITS=( ${PLUMAGE_EXITS[-3,-1]} )

  # per-command work belonging to the active theme, if it declared any
  if [[ -n ${PLUMAGE_THEME_PRECMD:-} ]] && (( $+functions[$PLUMAGE_THEME_PRECMD] )); then
    $PLUMAGE_THEME_PRECMD
  fi
  return 0
}

plumage_hook_up() {
  autoload -Uz add-zsh-hook
  add-zsh-hook preexec _plumage_preexec
  precmd_functions=( _plumage_capture ${precmd_functions:#_plumage_capture} )
}
