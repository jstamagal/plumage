# ▌rhel▐
#   plumage/rhel — enterprise grade
# tagline: crimson tab, ten-year lifecycle, subscription status attached
#
# The stable one your employer pays for. The right-hand side keeps
# the subscription honest: one failed command and it lapses.
# It always comes back. That is the business model.

PROMPT='%K{124}%F{231} rhel${PLUMAGE_OS_VERSION%%.*} %k%f %F{252}%n%F{240}·%F{167}${PLUMAGE_BOX}%f %F{240}(%F{250}%~%F{240})%f %(?.%F{124}.%F{203})▸%f '
RPROMPT='%(?.%F{240}subscription⁚%F{70}active%f.%F{240}subscription⁚%F{203}lapsed%f)'
