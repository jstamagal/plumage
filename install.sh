#!/bin/sh
# plumage installer — puts the plugin where oh-my-zsh will find it
# and adds it to your plugins list.
#
#   curl -fsSL https://raw.githubusercontent.com/jstamagal/plumage/main/install.sh | sh
#   ./install.sh              (from a checkout)
#   ./install.sh --uninstall

set -e

REPO="${PLUMAGE_REPO:-https://github.com/jstamagal/plumage}"
ZSHRC="${ZDOTDIR:-$HOME}/.zshrc"

say()  { printf '%s\n' "plumage: $*"; }
fail() { printf '%s\n' "plumage: $*" >&2; exit 1; }

# ── find oh-my-zsh's custom directory ───────────────────────────────
find_custom() {
  if [ -n "$ZSH_CUSTOM" ] && [ -d "$ZSH_CUSTOM" ]; then
    printf '%s' "$ZSH_CUSTOM"; return
  fi
  # ask a real interactive zsh — survives creative .zshrc arrangements
  if command -v zsh >/dev/null 2>&1; then
    probed=$(zsh -ic 'print -rn -- "@@@${ZSH_CUSTOM}@@@"' 2>/dev/null | sed -n 's/.*@@@\(.*\)@@@.*/\1/p')
    if [ -n "$probed" ] && [ -d "$probed" ]; then
      printf '%s' "$probed"; return
    fi
  fi
  if [ -n "$ZSH" ] && [ -d "$ZSH/custom" ]; then
    printf '%s' "$ZSH/custom"; return
  fi
  for d in "$HOME/.oh-my-zsh" "$HOME/.ohmyzsh" "$HOME/ohmy"; do
    if [ -f "$d/oh-my-zsh.sh" ]; then
      printf '%s' "$d/custom"; return
    fi
  done
  printf ''
}

CUSTOM=$(find_custom)
[ -n "$CUSTOM" ] || fail "could not find your oh-my-zsh install; set ZSH_CUSTOM and retry."
DEST="$CUSTOM/plugins/plumage"

# ── uninstall ───────────────────────────────────────────────────────
if [ "$1" = "--uninstall" ]; then
  rm -rf "$DEST"
  if [ -f "$ZSHRC" ]; then
    sed -i.plumage-bak -e 's/^\(plugins=([^)]*\) *plumage\([^)]*)\)/\1\2/' \
                       -e 's/^\(plugins=(\)plumage \{0,1\}/\1/' "$ZSHRC"
  fi
  say "removed $DEST and cleaned $ZSHRC (backup: $ZSHRC.plumage-bak)"
  exit 0
fi

# ── install the files ───────────────────────────────────────────────
here=$(CDPATH= cd -- "$(dirname -- "$0")" 2>/dev/null && pwd)
if [ -n "$here" ] && [ -f "$here/plumage.plugin.zsh" ]; then
  say "installing from local checkout: $here"
  mkdir -p "$DEST"
  cp -R "$here/plumage.plugin.zsh" "$here/lib" "$here/themes" "$here/tools" "$DEST/"
elif command -v git >/dev/null 2>&1; then
  if [ -d "$DEST/.git" ]; then
    say "updating existing install"
    git -C "$DEST" pull --quiet
  else
    rm -rf "$DEST"
    git clone --quiet --depth 1 "$REPO" "$DEST"
  fi
else
  fail "need git (or run me from a checkout)."
fi

# ── wire it into .zshrc ─────────────────────────────────────────────
if [ ! -f "$ZSHRC" ]; then
  say "no $ZSHRC found — add 'plumage' to your oh-my-zsh plugins yourself."
elif grep -Eq '^[^#]*plugins=\([^)]*\bplumage\b' "$ZSHRC"; then
  say "already in your plugins list"
elif grep -Eq '^plugins=\(' "$ZSHRC"; then
  sed -i.plumage-bak 's/^plugins=(/plugins=(plumage /' "$ZSHRC"
  say "added to plugins in $ZSHRC (backup: $ZSHRC.plumage-bak)"
else
  say "could not find a plugins=( ... ) line in $ZSHRC —"
  say "add 'plumage' to your oh-my-zsh plugins list by hand."
fi

say "installed to $DEST"
say "open a new shell (or 'exec zsh'), then step into a distrobox."
say "outside a box, try: plumage preview"
