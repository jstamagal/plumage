# [ ( ) ]
#   plumage/fallback — house colors
# tagline: for boxes we have not met: grey rails, white heart, honest badge
#
# Unknown distro, known manners. The badge shows whatever the box
# calls itself, and failures are noted plainly. If you are seeing
# this a lot, open an issue — or a theme.

PROMPT='%F{240}[%F{252}${PLUMAGE_OS_ID:-linux}%F{240}(%F{250}${PLUMAGE_BOX}%F{240})]%f %F{240}(%F{250}%~%F{240})%f%(?.. %F{240}‹%F{203}exit⁚%?%F{240}›%f) %F{250}»%f '
RPROMPT='%F{240}%D{%H:%M}%f'
