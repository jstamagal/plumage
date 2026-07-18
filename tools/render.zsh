#!/usr/bin/env zsh
# plumage/render — draw one theme's prompt right here, no container needed.
# usage: zsh -f render.zsh <plugin-root> <theme-name>

emulate zsh
setopt prompt_subst extended_glob multibyte

local root=${1:?need plugin root} name=${2:?need theme name}

source "$root/lib/core.zsh" || exit 1

PLUMAGE_BOX="$name"
PLUMAGE_OS_ID=$name
PLUMAGE_OS_LIKE=''
PLUMAGE_OS_VERSION=42
PLUMAGE_OS_CODENAME=trixie
PLUMAGE_OS_PRETTY="$name (preview)"
PLUMAGE_GIT=0
PLUMAGE_THEME_PRECMD=''
: ${USER:=you}

source "$root/themes/$name.zsh-theme" || exit 1

_render() {  # $1 = exit code, $2 = streak
  PLUMAGE_EXIT=$1
  PLUMAGE_STREAK=$2
  PLUMAGE_EXITS=( 0 0 $1 )
  PLUMAGE_TOOK='2.3s'
  PLUMAGE_TOOK_S=2.3
  [[ -n $PLUMAGE_THEME_PRECMD ]] && (( $+functions[$PLUMAGE_THEME_PRECMD] )) && $PLUMAGE_THEME_PRECMD
  ( exit $1 )
  local left="${(%%)PROMPT}" right="${(%%)RPROMPT}"
  if [[ -n $right ]]; then
    # right prompt sits at the terminal edge; approximate that here
    local lplain=${left//$'\e'\[[;0-9]#m/} rplain=${right//$'\e'\[[;0-9]#m/}
    local lastline=${${(f)lplain}[-1]}
    local pad=$(( ${COLUMNS:-100} - ${(m)#lastline} - ${(m)#rplain} - 8 ))
    (( pad < 1 )) && pad=1
    print -rn -- "$left"
    print -rn -- "${(l:pad:: :):-}"
    print -r -- "$right"
  else
    print -r -- "$left"
  fi
}

print -P "%F{240}──── ${name} ────%f"
_render 0 4
_render 130 0
print
