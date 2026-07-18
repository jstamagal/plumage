# ┌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌┐
#   plumage/debian — the elder
# └╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌╌┘
# tagline: muted oxblood frame, codename on the door, nothing hurried
#
# Dotted rails because solid ones would be showing off. The release
# codename sits in the corner the way it has since before your
# terminal had truecolor.

PROMPT='%F{131}┌╌%F{240}(%F{252}%n%F{240}·%F{174}${PLUMAGE_BOX}%F{240})╌(%F{174}deb%F{240}·%F{252}${PLUMAGE_OS_CODENAME:-sid}%F{240})%f$(plumage_git_seg "%F{240}╌(%F{174}" "%F{240})%f")
%F{131}└╌%f %F{250}%~%f %(?.%F{131}.%F{203})%#%f '
RPROMPT='%F{240}%D{%H:%M}%f'
