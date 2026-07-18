# >>> plumage/gentoo — it compiles you
# tagline: purple >>> lines, green stars, and every command gets timed
#
# The prompt reads like build output because on this box, everything
# is build output. The right side reports how long your last
# "package" took and whether it merged clean.

PROMPT='%F{13}>>>%f %F{10}${PLUMAGE_BOX}%F{240}/%F{15}%1~%f %F{240}(%F{250}%~%F{240})%f$(plumage_git_seg " %F{240}use=%F{10}" "%f")
 %(?.%F{10}.%F{9})*%f '
RPROMPT='%(?.%F{240}[ %F{10}ok%F{240} ]%f.%F{240}[ %F{9}!!%F{240} ]%f) %F{240}${PLUMAGE_TOOK}%f'
