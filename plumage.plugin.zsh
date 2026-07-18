# plumage — every distrobox gets its own feathers.
#
# An oh-my-zsh plugin. On your host it stays out of the way; inside a
# distrobox container it dresses the prompt in that distro's plumage,
# so you always know which box you are standing in.
#
# knobs (export before the plugin loads, or per-session):
#   PLUMAGE_THEME=<name>   force a specific theme anywhere
#   PLUMAGE_HOST=1         also dress the host prompt (by host distro)
#   PLUMAGE_GIT=0          skip git lookups in prompts

0=${(%):-%N}
typeset -g PLUMAGE_ROOT=${0:A:h}

source "$PLUMAGE_ROOT/lib/core.zsh"

# ── pick a theme for this box ───────────────────────────────────────
plumage_theme_for() {
  local id=$1 like=$2 box=${3:l} t=''
  case $id in
    arch)                        t=arch ;;
    blackarch)                   t=blackarch ;;
    almalinux)                   t=alma ;;
    alpine)                      t=alpine ;;
    altlinux|alt)                t=alt ;;
    amzn)                        t=amazon ;;
    centos)                      t=centos ;;
    chimera)                     t=chimera ;;
    crystal)                     t=crystal ;;
    debian|neurodebian|raspbian) t=debian ;;
    deepin)                      t=deepin ;;
    fedora)                      t=fedora ;;
    gentoo)                      t=gentoo ;;
    kali)                        t=kali ;;
    linuxmint)                   t=mint ;;
    neon)                        t=neon ;;
    opensuse*|suse|sles)         t=opensuse ;;
    ol|oracle)                   t=oracle ;;
    rhel)                        t=rhel ;;
    rocky)                       t=rocky ;;
    slackware)                   t=slackware ;;
    steamos|bazzite)             t=steamos ;;
    ubuntu)                      t=ubuntu ;;
    vanilla|vanilla-os|vso)      t=vanilla ;;
    void)                        t=void ;;
    wolfi)                       t=wolfi ;;
  esac
  if [[ -z $t && -n $like ]]; then
    case $like in
      *arch*)          t=arch ;;
      *ubuntu*)        t=ubuntu ;;
      *debian*)        t=debian ;;
      *fedora*|*rhel*) t=fedora ;;
      *suse*)          t=opensuse ;;
      *alpine*)        t=alpine ;;
      *gentoo*)        t=gentoo ;;
    esac
  fi
  if [[ -z $t ]]; then          # last chance: the box name says it
    local f n
    for f in "$PLUMAGE_ROOT"/themes/*.zsh-theme(N); do
      n=${${f:t}%.zsh-theme}
      [[ $n == fallback ]] && continue
      [[ $box == *$n* ]] && { t=$n; break }
    done
  fi
  print -r -- "${t:-fallback}"
}

# ── apply / restore ─────────────────────────────────────────────────
plumage_apply() {
  local name=$1
  local f="$PLUMAGE_ROOT/themes/$name.zsh-theme"
  [[ -r $f ]] || { f="$PLUMAGE_ROOT/themes/fallback.zsh-theme"; name=fallback; }
  if [[ -z ${_plumage_saved:-} ]]; then
    typeset -g _plumage_saved=1
    typeset -g _plumage_saved_prompt=$PROMPT _plumage_saved_rprompt=$RPROMPT
  fi
  typeset -g PLUMAGE_THEME_PRECMD=''
  RPROMPT=''
  setopt prompt_subst
  source "$f"
  typeset -g PLUMAGE_ACTIVE=$name
  # run the theme's per-command hook once so the first prompt is populated
  [[ -n $PLUMAGE_THEME_PRECMD ]] && (( $+functions[$PLUMAGE_THEME_PRECMD] )) && $PLUMAGE_THEME_PRECMD
  return 0
}

_plumage_first_prompt() {
  add-zsh-hook -d precmd _plumage_first_prompt
  plumage_apply "$PLUMAGE_THEME"
}

# ── the plumage command ─────────────────────────────────────────────
plumage() {
  local root=$PLUMAGE_ROOT
  case ${1:-status} in
    list)
      local f n tag
      for f in "$root"/themes/*.zsh-theme; do
        n=${${f:t}%.zsh-theme}
        tag=$(grep -m1 '^# tagline:' "$f" | cut -d: -f2- | sed 's/^ //')
        printf '  %-11s %s\n' "$n" "$tag"
      done
      ;;
    preview)
      shift
      local names
      if (( $# )); then names=( "$@" )
      else names=( ${${(f)"$(print -rl -- "$root"/themes/*.zsh-theme(N:t))"}%.zsh-theme} )
      fi
      local n
      for n in $names; do
        zsh -f "$root/tools/render.zsh" "$root" "$n" || return 1
      done
      ;;
    use)
      [[ -z $2 ]] && { print 'usage: plumage use <theme>'; return 1; }
      plumage_read_os; plumage_hook_up
      plumage_apply "$2"
      ;;
    off)
      if [[ -n ${_plumage_saved:-} ]]; then
        PROMPT=$_plumage_saved_prompt RPROMPT=$_plumage_saved_rprompt
        PLUMAGE_ACTIVE=''
      fi
      ;;
    status)
      if [[ -n ${PLUMAGE_ACTIVE:-} ]]; then
        print "plumage: wearing '$PLUMAGE_ACTIVE' (box: ${PLUMAGE_BOX:-none}, id: ${PLUMAGE_OS_ID:-?})"
      elif [[ -n ${CONTAINER_ID:-} ]]; then
        print "plumage: in box '$CONTAINER_ID' but not yet applied"
      else
        print "plumage: dormant (not in a distrobox) — try 'plumage preview'"
      fi
      ;;
    *)
      print 'plumage: list | preview [theme…] | use <theme> | off | status'
      ;;
  esac
}

# ── activation ──────────────────────────────────────────────────────
if [[ -n ${PLUMAGE_THEME:-} || -n ${CONTAINER_ID:-} || ${PLUMAGE_HOST:-0} == 1 ]]; then
  plumage_read_os
  : ${PLUMAGE_THEME:=$(plumage_theme_for "$PLUMAGE_OS_ID" "$PLUMAGE_OS_LIKE" "$PLUMAGE_BOX")}
  plumage_hook_up
  autoload -Uz add-zsh-hook
  add-zsh-hook precmd _plumage_first_prompt
fi
